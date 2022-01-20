use llvm_sys as llvm;
use llvm::prelude::*;
use llvm::core::*;
use llvm::bit_reader::LLVMParseBitcodeInContext2;

use std::path::Path;
use std::ffi::{CStr, CString};
use std::mem;

use super::{Context, Function};
use crate::llvm_utils as utils; 


#[derive(Debug)]
pub struct Module {
    pub functions: Vec<Function>,
    pub module_ref: LLVMModuleRef,
}

impl Module {
    pub fn from_bc_path(path: impl AsRef<Path>) -> Result<Self, String> {
        // implementation here inspired by the `inkwell` crate's `Module::parse_bitcode_from_path`
        let path = CString::new(
            path.as_ref()
                .to_str()
                .expect("Did not find a valid Unicode path string"),
        )
        .expect("Failed to convert to CString");

        // read the module's bitcode into a memory buffer 
        let memory_buffer = unsafe {
            let mut memory_buffer = std::ptr::null_mut();
            let mut err_string = std::mem::zeroed();
            let return_code = LLVMCreateMemoryBufferWithContentsOfFile(
                path.as_ptr() as *const _,
                &mut memory_buffer,
                &mut err_string,
            );
            if return_code != 0 {
                return Err(CStr::from_ptr(err_string)
                    .to_str()
                    .expect("Failed to convert CStr")
                    .to_owned());
            }
            memory_buffer
        };

        let context = Context::new();

        // parse the bitcode (in the memory buffer) into a LLVMModuleRef
        let module_ref = unsafe {
            let mut module: mem::MaybeUninit<LLVMModuleRef> = mem::MaybeUninit::uninit();

            let return_code =
                LLVMParseBitcodeInContext2(context.ctx, memory_buffer, module.as_mut_ptr());

            LLVMDisposeMemoryBuffer(memory_buffer);

            if return_code != 0 {
                return Err("Failed to parse bitcode".to_string());
            }

            module.assume_init()
        };

        let context = Context::from_module(module_ref); // TODO: Remove?

        let kind_id = context.get_kind_id("prof");

        let mut functions = vec![]; 

        for fn_ref in utils::get_defined_functions(module_ref) {

            // function_md.push(Metadata::extract_metadata(fn_ref, kind_id));

            // let bbs_refs = utils::get_basic_blocks(fn_ref);
            // println!("basic blocks count: {}", bbs_refs.count());
            // panic!();
            
            functions.push(Function::from_llvm_ref(fn_ref, kind_id));
        }

        // println!("Functions:\n{:#?}", functions);

        Ok(Self { functions, module_ref })
    }

    
    pub fn get_id(&self) -> String {
        unsafe { 
            let mut len = 0;
            let ptr = LLVMGetModuleIdentifier(self.module_ref, &mut len);

            utils::raw_to_string(ptr)
        }
    }

    /// Returns a list of all the functions of the module ordered by the entry count metadata
    /// (in descending order). 
    pub fn functions_sort_hottest(&self) -> Vec<(u64, &Function)> {
        let mut funcs = vec![];

        for func in &self.functions {
            /*
            if let Some(entry_md) = &func.entry_md {
                match entry_md {
                    Metadata::Node(nodes) => {
                        let mut it = nodes.iter();
                        if let Some(Metadata::String(str_data)) = it.next() {
                            if str_data == "function_entry_count" {
                                match it.next() {
                                    Some(Metadata::IntValue(data)) => {
                                        funcs.push((data, func));
                                    },
                                    _ => unreachable!(),
                                }
                            } else {
                                continue;
                            }
                        }
                    },
                    _ => continue,
                }
            }
            */
            if let Some(count) = func.get_entry_count() {
                funcs.push((count, func));
            }
        }

        funcs.sort_by_key(|(ec, _)| *ec);

        funcs.iter()
            .rev()
            .map(|&(v, f)| (v,f))
            .collect()
    }
} 

/*
impl Drop for Module {
    fn drop(&mut self) {
        unsafe {
            LLVMDisposeModule(self.module_ref);
        }
    }
}
*/
