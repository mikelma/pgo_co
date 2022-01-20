use pgo_co::{
    profdata::Module,
    ir_modifier,
};

use std::env;

fn main() {
    let mut args = env::args().skip(1);
    let in_path = match args.next() {
        Some(p) => p,
        None => {
            eprintln!("Missing path to the LLVM-IR bitcode to parse");
            std::process::exit(1);
        },
    };

    let out_path = match args.next() {
        Some(p) => p,
        None => {
            eprintln!("Missing output path");
            std::process::exit(1);
        },
    };

    let module = Module::from_bc_path(in_path).unwrap();
    
    for function in &module.functions {
        ir_modifier::reorder_blocks(function.function_ref);
    }

    module.to_path(&out_path).unwrap();
}
