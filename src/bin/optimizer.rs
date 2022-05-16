// use rand::seq::SliceRandom;
use clap::Parser;

use pgo_co::{
    co::{self, CoProblem},
    fatal_error, ir_modifier,
    profdata::Module,
};

use std::collections::HashMap;
use std::fs;

/// Optimize profiled LLVM-IR with metaheuristics
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Path to the CO problem instance
    #[clap(short = 'p', long = "instance")]
    inst_path: String,

    /// Path to the LLVM bitcode to optimize
    #[clap(short = 'i', long = "input-bc")]
    input_bc_path: String,

    /// Path to write the optimized program to
    #[clap(short, long = "out", default_value = "out.ll")]
    out_path: String,

    #[clap(short, long, parse(from_occurrences))]
    verbosity: usize,
}

fn main() {
    let args = Args::parse();

    // deserialize CO problem instance
    let problem_set: HashMap<String, CoProblem> = match fs::read_to_string(&args.inst_path) {
        Ok(in_str) => match serde_json::from_str(&in_str) {
            Ok(de) => de,
            Err(e) => fatal_error(format!("Failed to parse instance: {e}").as_str()),
        },
        Err(e) => {
            fatal_error(format!("Cannot open instance file `{}`: {e}", args.inst_path).as_str())
        }
    };

    let module = Module::from_bc_path(args.input_bc_path).unwrap();
    // let mut rng = rand::thread_rng();

    for function in &module.functions {
        let problem = match problem_set.get(&function.name) {
            Some(p) => p,
            None => fatal_error(
                format!(
                    "Function `{}` exists in the input program but not in the instance",
                    function.name
                )
                .as_str(),
            ),
        };

        let identity = (0..problem.n).collect::<Vec<usize>>();
        let (ls_sol, ls_fitness) = co::local_search::run(&problem, 1000);

        if args.verbosity > 0 {
            println!("{}", function.name);
            println!("  * Fitness of identity:    {}", problem.eval(&identity));
            println!("  * LS fitness:             {}\n", ls_fitness);
            if args.verbosity > 1 {
                println!("  * Optimized solution: {:?}", ls_sol);
            }
        }

        ir_modifier::reorder_blocks(function.function_ref, &ls_sol);
    }

    /*
    for function in &module.functions {
        if let Some(problem) = CoProblem::block_reordering_from(function) {
            // generate a random solution
            // let mut permu = (0..problem.n).collect::<Vec<usize>>();
            // permu.shuffle(&mut rng);
            // let fitness = problem.eval(&permu);

            let identity = (0..problem.n).collect::<Vec<usize>>();

            // let constr_sol = co::constructive::construct_solution(&problem, 3, 2);
            let (lc_sol, lc_fitness) = co::local_search::run(&problem, 1000);
            // let (sa_sol, sa_fitness) = co::sa::run(&problem, 1000, 1000000.0, 0.95, 10000.0, 100);
            // let (eda_sol, eda_fitness) = co::eda::run(&problem, 10, 10);

            // println!("random permu: {:?}", permu);
            // println!("constructive permu: {:?}", constr_sol);
            // println!("lc permu:           {:?}", lc_sol);
            // println!("sa permu:           {:?}", sa_sol);
            // println!("eda permu:          {:?}", eda_sol);
            // println!("\nconstructive fitness:   {}", problem.eval(&constr_sol));
            println!("Fitness of identity:    {}", problem.eval(&identity));
            println!("lc fitness:             {}", lc_fitness);
            // println!("Random permu fitness;   {fitness}");
            // println!("sa fitness:             {}", sa_fitness);
            // println!("eda fitness:            {}", eda_fitness);
            // println!("random permu fitness:   {}", problem.eval(&permu));
            println!("function: {}, n: {}", function.name, problem.n);

            // modify the source IR based on the solution
            // ir_modifier::reorder_blocks(function.function_ref, &permu);

            println!("* Modifying LLVM-IR with LS solution");
            ir_modifier::reorder_blocks(function.function_ref, &lc_sol);
        }
    }
    */

    if let Err(e) = module.to_path(&args.out_path) {
        fatal_error(format!("Cannot write output to `{}`: {e}", &args.out_path).as_str());
    }
}
