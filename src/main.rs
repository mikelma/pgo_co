use pgo_co::prof_md::Module;

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
    // println!("{:#?}", module);
    
    module.functions_sort_hottest()
          .iter()
          .for_each(|(v, f)| println!("{}: {}", v, f.name));

    println!("\n Read order:");
    module.functions
          .iter()
          .for_each(|f| println!("{}: {}", f.name, f.get_entry_count().unwrap_or(0)));
}
