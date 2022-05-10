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

    let module = Module::from_bc_path(in_path).unwrap();

    for func in module.functions {
        println!("* name: {}", func.name);

        // print basic block info
        for (i, branches) in func.bbs_branch_tree.iter().enumerate() {
            println!(
                "  + bb={i}, size={}, branches to: {:?}",
                func.bbs_num_instrs[i], branches
            );
        }

        // print CO problem generated
        let problem = co::CoProblem::block_reordering_from(&func).unwrap();
        println!("  + C:");
        problem.c.iter().for_each(|v| println!("     {:?}", v));

        println!("  + s:\n    {:?}", problem.s);
    }
}
