use super::CoProblem;
use rand::{distributions::*, seq::SliceRandom};

struct Umd(Vec<Vec<usize>>);
struct Population(Vec<Vec<usize>>);

pub fn run(problem: &CoProblem, pop_size: usize, iters: usize) -> (Vec<usize>, u64) {
    let mut pop = Population::init(problem.n, pop_size);
    let num_select = pop_size / 2;

    let mut best_f = 0;
    let mut best_sol: Vec<usize> = vec![];

    // println!("* pop:");
    // pop.0.iter().for_each(|p| println!("{:?}", p));

    for it in 0..iters {
        #[cfg(debug_assertions)]
        pop.stats(it, problem);

        let best_sol_info = pop.select_survivors(problem, num_select);

        let (iter_best_idx, iter_best_f) = best_sol_info
            .iter()
            .max_by(|(_, a), (_, b)| a.cmp(b))
            .unwrap();
        if *iter_best_f > best_f {
            best_sol = pop.0[*iter_best_idx].clone();
            best_f = *iter_best_f;
        }

        // indexes of the non selected solutions (worsts)
        let worsts_index = (0..pop_size)
            .filter(|i| best_sol_info.iter().find(|(j, _)| i == j).is_some())
            .collect::<Vec<usize>>();

        let bests = best_sol_info
            .iter()
            .map(|(i, _)| &pop.0[*i])
            .collect::<Vec<&Vec<usize>>>();

        let distrib = Umd::from(&bests);

        distrib.sample_and_replace(&mut pop, &worsts_index);

        if best_sol.is_empty() {
            panic!();
        }
    }

    (best_sol, best_f)
}

impl Population {
    pub fn init(length: usize, pop_size: usize) -> Self {
        let mut rng = rand::thread_rng();
        let pop = (0..pop_size)
            .map(|_| {
                let mut v = (0..length).collect::<Vec<usize>>();
                v.shuffle(&mut rng);
                v
            })
            .collect::<Vec<Vec<usize>>>();
        Population(pop)
    }

    #[cfg(debug_assertions)]
    pub fn stats(&self, iter: usize, problem: &CoProblem) {
        let pop_size = self.0.len();

        let f = self.0.iter().map(|s| problem.eval(s)).collect::<Vec<u64>>();

        let f_sum: u64 = f.iter().sum();
        let f_min = f.iter().min().unwrap();
        let f_max = f.iter().max().unwrap();

        let mean = f_sum / pop_size as u64;

        println!("(debug mode) iter: {iter} -> ({f_min}, {mean}, {f_max})");
    }

    // First, the function evaluates all the solutions of the population.
    // Then, solutions are sorted based on their fitness value (descending order),
    // and the index and fitness value of the first `num_select` solutions is returned.
    pub fn select_survivors(&self, problem: &CoProblem, num_select: usize) -> Vec<(usize, u64)> {
        let mut f = self
            .0
            .iter()
            .enumerate()
            .map(|(i, s)| (i, problem.eval(s)))
            .collect::<Vec<(usize, u64)>>();

        f.sort_by(|(_, s1), (_, s2)| s2.cmp(s1));
        // just return the first `num_select` solutions
        f.truncate(num_select);
        f
    }
}

impl Umd {
    pub fn from(pop: &Vec<&Vec<usize>>) -> Self {
        let n = pop[0].len();
        let mut d = vec![vec![0; n]; n];

        for s in pop {
            for (i, e) in s.iter().enumerate() {
                d[i][*e] += 1;
            }
        }
        Umd(d)
    }

    pub fn sample_and_replace(&self, out: &mut Population, indexes: &[usize]) {
        let mut rng = rand::thread_rng();
        let n = self.0.len();

        // TODO: sort `index` for better cache performance?

        let mut sampled = Vec::with_capacity(n);
        let mut new_w = (0..n)
            .map(|i| (i, &self.0[0][i]))
            .collect::<Vec<(usize, &usize)>>();
        let mut wi = WeightedIndex::new(vec![1usize; n]).unwrap();

        for sol_idx in indexes {
            for pos in 0..n {
                let v = wi.sample(&mut rng);
                out.0[*sol_idx][pos] = v;
                sampled.push(v);

                if sampled.len() < n {
                    let mut all_zeros = true;
                    for (i, w) in &mut new_w {
                        if sampled.contains(i) {
                            *w = &0;
                        } else {
                            let v = &self.0[pos + 1][*i];
                            *w = v;
                            if *v != 0 {
                                all_zeros = false;
                            }
                        }
                    }

                    if all_zeros {
                        new_w
                            .iter_mut()
                            .filter(|(i, _)| !sampled.contains(i))
                            .for_each(|v| v.1 = &1);
                    }
                }

                wi.update_weights(new_w.as_slice()).unwrap();
            }
            sampled.clear();
            // std::process::exit(42);
        }
    }
}
