use rand::seq::SliceRandom;

use pgo_co::{
    co::{self, CoProblem},
    ir_modifier,
    profdata::Module,
};

use std::env;

fn main() {
    let mut args = env::args().skip(1);
    let in_path = match args.next() {
        Some(p) => p,
        None => {
            eprintln!("Missing path to the LLVM-IR bitcode to parse");
            std::process::exit(1);
        }
    };

    let out_path = match args.next() {
        Some(p) => p,
        None => {
            eprintln!("Missing output path");
            std::process::exit(1);
        }
    };

    let module = Module::from_bc_path(in_path).unwrap();
    let mut rng = rand::thread_rng();

    for function in &module.functions {
        if let Some(problem) = CoProblem::block_reordering_from(function) {
            // generate a random solution
            let mut permu = (0..problem.n).collect::<Vec<usize>>();
            permu.shuffle(&mut rng);

            let fitness = problem.eval(&permu);
            // println!("random permu: {:?}", permu);

            let constr_sol = co::constructive::construct_solution(&problem, 3, 2);
            let (lc_sol, lc_fitness) = co::local_search::run(&problem, 1000);
            let (sa_sol, sa_fitness) = co::sa::run(&problem, 1000, 1000000.0, 0.95, 10000.0, 100);
            let (eda_sol, eda_fitness) = co::eda::run(&problem, 10, 10);

            println!("constructive permu: {:?}", constr_sol);
            println!("lc permu:           {:?}", lc_sol);
            println!("sa permu:           {:?}", sa_sol);
            println!("eda permu:          {:?}", eda_sol);
            println!("\nconstructive fitness:   {}", problem.eval(&constr_sol));
            println!("lc fitness:             {}", lc_fitness);
            println!("sa fitness:             {}", sa_fitness);
            println!("eda fitness:            {}", eda_fitness);
            println!("random permu fitness:   {}", problem.eval(&permu));
            println!(
                "function: {}, n: {}, f: {fitness}",
                function.name, problem.n
            );

            // modify the source IR based on the solution
            ir_modifier::reorder_blocks(function.function_ref, &permu);
        }
    }

    module.to_path(&out_path).unwrap();
}
