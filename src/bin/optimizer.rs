// use rand::seq::SliceRandom;
use clap::Parser;

use pgo_co::{
    co::{self, CoProblem},
    fatal_error, ir_modifier,
    profdata::Module,
};

use std::fs;
use std::str::FromStr;
use std::{collections::HashMap, path::PathBuf};

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

    #[clap(short, long, default_value = "LS")]
    algorithm: Algorithm,

    #[cfg(feature = "log")]
    #[clap(short, long, default_value = ".")]
    log_path: String,
}

#[derive(Debug)]
enum Algorithm {
    Constructive,
    LocalSearch,
    SimulatedAnnealing,
    Eda,
}

impl FromStr for Algorithm {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        use Algorithm::*;
        match s {
            "constructive" => Ok(Constructive),
            "LS" => Ok(LocalSearch),
            "SA" => Ok(SimulatedAnnealing),
            "EDA" => Ok(Eda),
            _ => Err(format!(
                "Invalid algorithm {s}. Valid options are: constructive, LS, SA and EDA"
            )),
        }
    }
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

    let module = Module::from_bc_path(&args.input_bc_path).unwrap();
    // let mut rng = rand::thread_rng();

    #[cfg(feature = "log")]
    pgo_co::log::set_log_dir(args.log_path);

    #[cfg(feature = "log")]
    let opt_file = PathBuf::from(args.input_bc_path)
        .file_stem()
        .unwrap()
        .to_string_lossy()
        .to_string();

    #[cfg(feature = "log")]
    let inst_name = PathBuf::from(args.inst_path)
        .file_stem()
        .unwrap()
        .to_string_lossy()
        .to_string();

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
        let iden_fitness = problem.eval(&identity);

        #[cfg(feature = "log")]
        {
            pgo_co::log::set_attr("function", &function.name);
            pgo_co::log::set_attr("num blocks", &function.num_bbs);
            pgo_co::log::set_attr("opt file", &opt_file);
            pgo_co::log::set_attr("instance", &inst_name);
            pgo_co::log::set_attr("identity fitness", iden_fitness);
            pgo_co::log::set_attr("max opt time", pgo_co::MAX_OPT_MILLIS);
        }

        let (opt_sol, opt_fitness) = match args.algorithm {
            Algorithm::LocalSearch => co::local_search::run(&problem),
            Algorithm::Constructive => co::constructive::construct_solution(&problem, 3, 2),
            Algorithm::SimulatedAnnealing => co::sa::run(&problem, 1000000.0, 0.95, 10000.0, 100),
            Algorithm::Eda => co::eda::run(&problem, 300, 100),
        };

        ir_modifier::reorder_blocks(function.function_ref, &opt_sol);

        if args.verbosity > 0 {
            println!("{}", function.name);
            println!("  * Fitness of identity: {}", iden_fitness);
            println!("  * {:?} fitness: {}\n", args.algorithm, opt_fitness);
            if args.verbosity > 1 {
                println!("  * Optimized solution: {:?}", opt_sol);
            }
        }
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
