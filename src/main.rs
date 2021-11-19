use pgo_co::Module;

use std::env;

fn main() {
    let path = match env::args().skip(1).next() {
        Some(p) => p,
        None => {
            eprintln!("Missing path to the LLVM-IR bitcode to parse");
            std::process::exit(1);
        },
    };

    let module = Module::from_bc_path(path).unwrap();
    println!("{:#?}", module);
}
