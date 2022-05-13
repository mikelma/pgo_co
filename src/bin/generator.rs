use pgo_co::{co::CoProblem, profdata::Module};

use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let mut args = env::args().skip(1);
    let in_path = match args.next() {
        Some(p) => p,
        None => {
            eprintln!("Missing path to the LLVM-IR bitcode to parse");
            std::process::exit(1);
        }
    };

    let module = Module::from_bc_path(in_path).unwrap();
    let mut map = HashMap::new();

    for func in module.functions {
        let problem = CoProblem::block_reordering_from(&func).unwrap();
        map.insert(func.name, problem);
    }

    let inst_str = ron::to_string(&map).unwrap();

    match args.next() {
        Some(p) => fs::write(p, inst_str).unwrap(),
        None => println!("{inst_str}"),
    }
}
