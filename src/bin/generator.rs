use clap::Parser;

use pgo_co::{
    co::CoProblem,
    profdata::{Function, Module},
};

use std::collections::HashMap;
use std::fs;

/// Generate a CO problem instance from profiled LLVM-IR bitcode
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Path to the LLVM bitcode to generate the instance from
    #[clap(short, long = "input-bc")]
    input_bc_path: String,

    /// Path to the output file. If not provided, the output is
    /// dumped to stdout
    #[clap(short, long)]
    out_path: Option<String>,

    /// Maximum number of functions to consider. Functions are
    /// sorted from hottest to coldest if this argument is used.
    #[clap(short = 'n', long)]
    max_num_funcs: Option<usize>,

    /// Minimum number of basic blocks that a function must have in
    // order to be considered. Disabled by default
    #[clap(long)]
    min_bb_num: Option<usize>,

    /// Maximum number of basic blocks that a function must have in
    /// order to be considered. Disabled by default
    #[clap(long)]
    max_bb_num: Option<usize>,
}

fn main() {
    let args = Args::parse();

    let module = Module::from_bc_path(args.input_bc_path).unwrap();
    let mut map = HashMap::new();

    let mut functions = module
        .functions_sort_hottest()
        .iter()
        .map(|(_, v)| *v)
        .collect::<Vec<&Function>>();

    // if needed, truncate the list of functions to consider
    if let Some(n) = args.max_num_funcs {
        functions.truncate(n);
    }

    for func in functions {
        // do nothing if the function has no metadata
        if let Some(problem) = CoProblem::block_reordering_from(&func) {
            // check minimum number of BBs
            match args.min_bb_num {
                Some(min) if min > problem.n => continue,
                _ => (),
            }

            // check maximum number of BBs
            match args.max_bb_num {
                Some(max) if max <= problem.n => continue,
                _ => (),
            }

            // Don't push the probelm if the C matrix is only zeros
            if !problem.is_zeros() {
                map.insert(func.name.clone(), problem);
            }
        }
    }

    let inst_str = serde_json::to_string(&map).unwrap();

    match args.out_path {
        Some(p) => fs::write(p, inst_str).unwrap(),
        None => println!("{inst_str}"),
    }
}
