use llvm_sys::{
    prelude::*, 
    core::*,
};

pub struct Context {
    pub ctx: LLVMContextRef,
}

impl Context {
    pub fn new() -> Self {
        Self {
            ctx: unsafe { LLVMContextCreate() },
        }
    }

    pub fn from_module(module: LLVMModuleRef) -> Self {
        let ctx = unsafe {
            LLVMGetModuleContext(module)
        };

        Self { ctx }
    }

    pub fn get_kind_id(&self, key: &str) -> u32 {
        unsafe {
            LLVMGetMDKindIDInContext(self.ctx, key.as_ptr() as *const ::libc::c_char, key.len() as u32)
        }
    }
}

/*
impl Drop for Context {
    fn drop(&mut self) {
        unsafe {
            LLVMContextDispose(self.ctx);
        }
    }
}
*/
