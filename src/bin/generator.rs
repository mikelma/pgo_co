use clap::Parser;

use pgo_co::{co::CoProblem, profdata::Module};

use std::collections::HashMap;
use std::fs;


/// Generate a CO problem instance from profiled LLVM-IR bitcode 
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Path to the LLVM bitcode to generate the instance from 
    #[clap(short, long="input-bc")]
    input_bc_path: String,

    /// Path to the output file. If not provided, the output is dumped to stdout
    #[clap(short, long)]
    out_path: Option<String>,
}

fn main() {
    let args = Args::parse();

    let module = Module::from_bc_path(args.input_bc_path).unwrap();
    let mut map = HashMap::new();

    for func in module.functions {
        let problem = CoProblem::block_reordering_from(&func).unwrap();
        map.insert(func.name, problem);
    }

    let inst_str = serde_json::to_string(&map).unwrap();

    match args.out_path {
        Some(p) => fs::write(p, inst_str).unwrap(),
        None => println!("{inst_str}"),
    }
}
