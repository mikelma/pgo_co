use rand::prelude::*;
use rand::seq::SliceRandom;

use std::time::Instant;

#[cfg(feature = "log")]
use crate::log;

use super::CoProblem;
use crate::MAX_OPT_MILLIS;

pub fn run(
    problem: &CoProblem,
    temp_init: f64,
    temp_update: f64,
    temp_end: f64,
    temp_update_iters: usize,
) -> (Vec<usize>, u64) {
    let time = Instant::now();
    let mut temp = temp_init;

    let mut rng = rand::thread_rng();
    let mut best_solution = (0..problem.n).collect::<Vec<usize>>();
    best_solution.shuffle(&mut rng);

    let mut best_solution_f = problem.eval(&best_solution);

    let mut solution = best_solution.clone();
    let mut solution_f = problem.eval(&solution);

    #[cfg(feature = "log")]
    let mut evals = 2;

    loop {
        for _it in 0..temp_update_iters {
            // get random neighbor
            let mut neighbor = solution.clone(); // TODO: Optimize
            let (_i, _j) = random_swap(&mut neighbor);

            let neighbor_f = problem.eval(&neighbor);

            #[cfg(feature = "log")]
            {
                evals += 1;
                log::log("time", time.elapsed().as_millis());
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

            if MAX_OPT_MILLIS <= time.elapsed().as_millis() {
                break;
            }
        }
        // update temperature
        if temp > temp_end {
            temp *= temp_update;
        }
        if MAX_OPT_MILLIS <= time.elapsed().as_millis() {
            break;
        }
    }

    #[cfg(feature = "log")]
    {
        log::set_attr("algorithm", "SA");
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
