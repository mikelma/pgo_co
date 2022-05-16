use clap::Parser;

use pgo_co::{co, profdata::Module};

/// Inpect profile metadata from LLVM-IR bitcode
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Name of the function to inspect. If not provided, all functions are inspected
    #[clap(short = 'f', long = "inspect-func")]
    inspect_func: Option<String>,

    /// Path to the LLVM bitcode to inspect
    #[clap(short = 'i', long = "input-bc")]
    input_bc_path: String,
    // TODO: Add verbosity option
    // #[clap(short, long, parse(from_occurrences))]
    // verbosity: usize
}

fn main() {
    let args = Args::parse();
    let module = Module::from_bc_path(args.input_bc_path).unwrap();

    for func in module.functions {
        if let Some(fn_name) = &args.inspect_func {
            if func.name != *fn_name {
                continue;
            }
        }

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
        println!();
    }
}
