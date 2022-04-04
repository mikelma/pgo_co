use llvm::core::*;
use llvm::prelude::*;
use llvm_sys as llvm;

use crate::llvm_utils as utils;

pub fn reorder_blocks(function: LLVMValueRef, order: &[usize]) {
    let entry = unsafe { LLVMGetFirstBasicBlock(function) };
    let bbs: Vec<LLVMBasicBlockRef> = utils::get_basic_blocks(function).skip(1).collect();
    unsafe {
        for index in order.iter().rev() {
            LLVMMoveBasicBlockAfter(bbs[*index], entry);
        }
    }
}

/*
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

    pub unsafe fn test(&self, profdata_mod: &ProfDataModule) {
        let mod_ref = profdata_mod.module_ref;

        let mut deleted = None;

        for func_ref in utils::get_defined_functions(mod_ref) {
            let name = utils::get_value_name(func_ref);


            if name == "list_set_i" {
                LLVMDumpValue(func_ref);
                println!(" - Removing: {}", name);
                deleted = Some(func_ref);
                LLVMDeleteFunction(func_ref);
            }
        }

        let fn_ref = deleted.unwrap();

        let mut len = 0;
        let id = LLVMGetValueName2(deleted.unwrap(), &mut len);
        let fn_ty = LLVMTypeOf(fn_ref);

        // add the new function to the new module
        let new_fn = LLVMAddFunction(mod_ref, id, fn_ty);

        // append each basic block of the olf function to the new one
        for bb in utils::get_basic_blocks(fn_ref) {
            LLVMAppendExistingBasicBlock(new_fn, bb);
        }

        // LLVMDumpModule(mod_ref)
    }

    /// Creates a new LLVM module, based on the given `pprofdata::Module` and the function order
    /// list.
    pub fn create_module_from(&mut self,
                              profdata_mod: &ProfDataModule,
                              function_order: &[&str]) -> Module {
        let module_ref = unsafe {
            let mod_ref = LLVMCloneModule(profdata_mod.module_ref);

            // remove all functions present in `function_order` from the cloned module
            for func_ref in utils::get_defined_functions(mod_ref) {
                let name = utils::get_value_name(func_ref);
                if function_order.contains(&name.as_str()) {
                    // println!(" - Removing: {}", name);
                    LLVMDeleteFunction(func_ref);
                }
            }

            self.ctx_ref = LLVMGetModuleContext(mod_ref);

            mod_ref
        };

        for fn_id in function_order {
            // get the function data from ProfDataModule
            let profdata_func = profdata_mod.functions
                .iter()
                .find(|f| f.name == *fn_id)
                .expect(format!("Function {} does not exist in module", fn_id).as_str());

            // println!(" - Adding: {}", fn_id);

            unsafe {
                let mut len = 0;
                let id = LLVMGetValueName2(profdata_func.function_ref, &mut len);

                let fn_ty = LLVMTypeOf(profdata_func.function_ref);

                println!("Number of params: {} -> {}",
                         utils::get_value_name(profdata_func.function_ref),
                         LLVMCountParams(profdata_func.function_ref));

                let ret_ty = LLVMGetReturnType(fn_ty);

                // get parameters of the ol function
                /*
                let count = LLVMCountParams(profdata_func.function_ref);
                let mut raw_vec: Vec<LLVMValueRef> = Vec::with_capacity(count as usize);
                let ptr = raw_vec.as_mut_ptr();
                forget(raw_vec);
                LLVMGetParams(profdata_func.function_ref, ptr);
                let raw_vec = {
                    Vec::from_raw_parts(ptr, count as usize, count as usize)
                };
                */

                let count = LLVMCountParams(profdata_func.function_ref);
                let mut raw_vec: Vec<LLVMTypeRef> = Vec::with_capacity(count as usize);
                let ptr = raw_vec.as_mut_ptr();
                forget(raw_vec);
                LLVMGetParamTypes(fn_ty, ptr);
                let mut raw_vec = {
                    Vec::from_raw_parts(ptr, count as usize, count as usize)
                };

                let fn_ty = LLVMFunctionType(
                    ret_ty,
                    raw_vec.as_mut_ptr(),
                    count,
                    LLVMIsFunctionVarArg(fn_ty)
                );

                LLVMDumpType(fn_ty);

                // add the new function to the new module
                let new_fn = LLVMAddFunction(module_ref, id, fn_ty);

                println!("New number of params: {} -> {}\n",
                         utils::get_value_name(new_fn),
                         LLVMCountParams(new_fn));

                // append each basic block of the olf function to the new one
                for old_bb in utils::get_basic_blocks(profdata_func.function_ref) {
                    LLVMAppendExistingBasicBlock(new_fn, old_bb);
                }
            }
        }

        // unsafe { LLVMDumpModule(module_ref); }

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
*/
