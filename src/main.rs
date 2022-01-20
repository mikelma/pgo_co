use pgo_co::profdata::Module;

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
    
    println!("\nHottest function sort (module: {}):", module.get_id());
    module.functions_sort_hottest()
          .iter()
          .for_each(|(v, f)| println!("{}: {}", v, f.name));

    let hottest_order = module.functions_sort_hottest()
        .iter()
        .map(|(_, f)| f.name.as_str())
        .collect::<Vec<&str>>();

    println!("\nRead order (module: {}):", module.get_id());
    module.functions
          .iter()
          .for_each(|f| println!("{}: {}", f.get_id(), f.get_entry_count().unwrap_or(0)));

    let ctx = pgo_co::ir_modifier::Context::new();
    // let new_module = ctx.create_module_from(&module, &["free_list", "list_fill_seq", "list_get_seq_values"]);
    let new_module = ctx.create_module_from(&module, &hottest_order);

    // new_module.to_path("probatzen.ll").unwrap();
    
    if let Err(err) = new_module.verify() {
        println!("{}", err);
    }
}
