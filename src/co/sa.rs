use rand::prelude::*;
use rand::seq::SliceRandom;

#[cfg(feature = "log")]
use crate::log;

use super::CoProblem;

pub fn run(
    problem: &CoProblem,
    max_evals: usize,
    temp_init: f64,
    temp_update: f64,
    temp_end: f64,
    temp_update_iters: usize,
) -> (Vec<usize>, u64) {
    let mut temp = temp_init;

    let mut rng = rand::thread_rng();
    let mut best_solution = (0..problem.n).collect::<Vec<usize>>();
    best_solution.shuffle(&mut rng);

    let mut best_solution_f = problem.eval(&best_solution);
    let mut evals = 1;

    let mut solution = best_solution.clone();
    let mut solution_f = problem.eval(&solution);
    evals += 1;

    loop {
        for _it in 0..temp_update_iters {
            // get random neighbor
            let mut neighbor = solution.clone(); // TODO: Optimize
            let (_i, _j) = random_swap(&mut neighbor);

            let neighbor_f = problem.eval(&neighbor);
            evals += 1;

            #[cfg(feature = "log")]
            {
                log::log("evaluation", evals);
                log::log("best fitness", best_solution_f);
            }

            let energy = (neighbor_f as i64 - solution_f as i64) as f64;

            if energy > 0. {
                solution_f = neighbor_f;
                solution = neighbor.clone();

                if solution_f > best_solution_f {
                    best_solution_f = solution_f;
                    best_solution = solution.clone();
                }
            } else {
                let r = rand::random::<f64>();
                if r < (energy / temp).exp() {
                    solution_f = neighbor_f;
                    solution = neighbor.clone();
                }
            }

            if evals >= max_evals {
                break;
            }
        }
        // update temperature
        if temp > temp_end {
            temp *= temp_update;
        }
        if evals >= max_evals {
            break;
        }
    }

    #[cfg(feature = "log")]
    {
        log::set_attr("algorithm", "SA");
        log::set_attr("max evals", max_evals);
        log::set_attr("temp init", temp_init);
        log::set_attr("temp update", temp_update);
        log::set_attr("temp end", temp_end);
        log::set_attr("temp update iters", temp_update_iters);
        log::write();
    }

    (best_solution, best_solution_f)
}

pub fn random_swap(s: &mut [usize]) -> (usize, usize) {
    let mut rng = rand::thread_rng();
    let i = rng.gen_range(0..s.len());
    let mut j = rng.gen_range(0..s.len());

    while i == j {
        j = rng.gen_range(0..s.len());
    }

    let v = s[i];
    s[i] = s[j];
    s[j] = v;

    (i, j)
}
