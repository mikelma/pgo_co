use llvm::analysis::LLVMVerifyModule;
use llvm_sys as llvm;
use llvm::prelude::*;
use llvm::core::*;
use llvm::analysis::LLVMVerifierFailureAction;

use std::ffi::CString;
use std::mem::MaybeUninit;

use crate::llvm_utils as utils;
use crate::profdata;
use profdata::Module as ProfDataModule;

pub struct Context {
    ctx_ref: LLVMContextRef,
}

pub struct Module {
    module_ref: LLVMModuleRef,
} 

impl Context {
    pub fn new() -> Self {
        Context {
            ctx_ref: unsafe {
                LLVMContextCreate()
            },
        }
    }

    /// Creates a new LLVM module, based on the given `pprofdata::Module` and the function order
    /// list.
    pub fn create_module_from(&self, 
                              profdata_mod: &ProfDataModule, 
                              function_order: &[&str]) -> Module {
        // create a new module based on the old module's info
        let module_ref = unsafe {// get info from old module
            let mut len = 0;
            let id = LLVMGetModuleIdentifier(profdata_mod.module_ref, &mut len);
            let layout = LLVMGetDataLayoutStr(profdata_mod.module_ref);
            let target = LLVMGetTarget(profdata_mod.module_ref);
            // let globals = utils::get_globals(profdata_mod.module_ref);

            let module = LLVMModuleCreateWithNameInContext(id, self.ctx_ref);
            LLVMSetDataLayout(module, layout);
            LLVMSetTarget(module, target);

            module
        };

        for fn_id in function_order {
            // get the function data from ProfDataModule
            let profdata_func = profdata_mod.functions
                .iter()
                .find(|f| f.name == *fn_id)
                .expect(format!("Function {} does not exist in module", fn_id).as_str());

            unsafe {
                let mut len = 0;
                let id = LLVMGetValueName2(profdata_func.function_ref, &mut len);
                let fn_ty = LLVMTypeOf(profdata_func.function_ref);

                // add the new function to the new module
                let new_fn = LLVMAddFunction(module_ref, id, fn_ty);

                // append each basic block of the olf function to the new one
                for bb in utils::get_basic_blocks(profdata_func.function_ref) {
                    LLVMAppendExistingBasicBlock(new_fn, bb);
                }
            }
        }

        Module { module_ref } 
    }
}

impl Module {
    // Writes the LLVM-IR of the module (in text format) to the specified output file.
    pub fn to_path(&self, path_str: &str) -> Result<(), String> {
        unsafe {
            let filename_cstr = utils::to_c_str(path_str);
            let mut err_str = MaybeUninit::uninit();

            if LLVMPrintModuleToFile(self.module_ref, filename_cstr.as_ptr(), err_str.as_mut_ptr()) != 0 {
                let err_str = err_str.assume_init();
                Err(CString::from_raw(err_str).to_string_lossy().to_string())

            } else {
                Ok(())
            }
        }
    }

    // Verify the current module. If any errors are found, an `Err` variant is returned, containing
    // a `String` with these errors. Else, `Ok` variant is returned.
    pub fn verify(&self) -> Result<(), String> {
        unsafe {
            let mut err_str = MaybeUninit::uninit();
            let action = LLVMVerifierFailureAction::LLVMReturnStatusAction;

            if LLVMVerifyModule(self.module_ref, action, err_str.as_mut_ptr()) != 0 {
                let err_str = err_str.assume_init();
                let err_str = CString::from_raw(err_str).to_string_lossy().to_string();

                Err(err_str)

            } else {
                Ok(())
            }
        }
    }
}
