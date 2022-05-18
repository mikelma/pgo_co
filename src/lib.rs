use std::process;

pub mod co;
pub mod ir_modifier;
pub mod llvm_utils;
pub mod profdata;

pub const MAX_OPT_MILLIS: u128 = 10_000;

#[cfg(feature = "log")]
pub mod log;

#[cfg(feature = "log")]
#[macro_use]
extern crate lazy_static;

pub fn fatal_error(msg: &str) -> ! {
    eprintln!("\x1b[31;1m[FATAL]\x1b[0m {msg}");
    eprintln!("Exitting...");
    process::exit(1);
}
