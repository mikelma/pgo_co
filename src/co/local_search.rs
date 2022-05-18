use rand::seq::SliceRandom;

#[cfg(feature = "log")]
use crate::log;

use std::time::Instant;

use super::CoProblem;
use crate::MAX_OPT_MILLIS;

pub fn run(problem: &CoProblem) -> (Vec<usize>, u64) {
    let time = Instant::now();

    let mut rng = rand::thread_rng();
    let mut best_solution = (0..problem.n).collect::<Vec<usize>>();
    best_solution.shuffle(&mut rng);

    let mut best_solution_f = problem.eval(&best_solution);

    #[cfg(feature = "log")]
    let mut evals = 1;

    loop {
        let mut solution = best_solution.clone();
        let mut update = false;

        let size = solution.len();
        for i in 0..(size - 1) {
            for j in (i + 1)..size {
                // perform swap
                let v = solution[i];
                solution[i] = solution[j];
                solution[j] = v;

                #[cfg(feature = "log")]
                {
                    evals += 1;
                    log::log("time", time.elapsed().as_millis());
                    log::log("evaluation", evals);
                    log::log("best fitness", best_solution_f);
                }

                let solution_f = problem.eval(&solution);

                if solution_f > best_solution_f {
                    best_solution_f = solution_f;
                    best_solution = solution.clone();
                    // best first selection method
                    update = true;
                    break;
                }

                if MAX_OPT_MILLIS <= time.elapsed().as_millis() {
                    break;
                }

                // undo swap
                solution[j] = solution[i];
                solution[i] = v;
            }
            if MAX_OPT_MILLIS <= time.elapsed().as_millis() {
                break;
            }
        }

        if !update || MAX_OPT_MILLIS <= time.elapsed().as_millis() {
            break;
        }
    }

    #[cfg(feature = "log")]
    {
        log::set_attr("algorithm", "LS");
        log::write();
    }

    (best_solution, best_solution_f)
}

/*
fn neighborhood_swap(solution: &mut [usize]) {
    let size = solution.len();
    for i in 0..(size-1) {
        for j in (i+1)..size {
            let v = solution[i];
            solution[i] = solution[j];
            solution[j] = v;

            // SOLUTION HERE

            println!("{:?}", solution);

            // undo
            solution[j] = solution[i];
            solution[i] = v;
        }
    }
}
*/
