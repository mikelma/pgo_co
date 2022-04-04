#![allow(unused_imports)]
#![allow(dead_code)]

use llvm_sys::core::*;
use llvm_sys::prelude::*;

pub use super::iterators::*;

use libc::c_char;
use std::borrow::Cow;
use std::ffi::{CStr, CString};

// We convert all LLVM strings to owned Strings (which involves a copy)
// partly because we intend to serialize/deserialize our ASTs eventually
pub unsafe fn raw_to_string(raw: *const c_char) -> String {
    let cstr = CStr::from_ptr(raw);
    cstr.to_str().expect("Failed to convert CStr").into()
}

pub fn rust_to_cstr(value: &str) -> *const c_char {
    CString::new(value)
        .expect("Cannot converto string to C str")
        .into_raw()
}

pub(crate) fn to_c_str<'s>(mut s: &'s str) -> Cow<'s, CStr> {
    if s.is_empty() {
        s = "\0";
    }

    // Start from the end of the string as it's the most likely place to find a null byte
    if s.chars().rev().find(|&ch| ch == '\0').is_none() {
        return Cow::from(CString::new(s).expect("unreachable since null bytes are checked"));
    }

    unsafe { Cow::from(CStr::from_ptr(s.as_ptr() as *const _)) }
}

macro_rules! wrap {
    ($llvmFunc:ident, $argty:ty, $wrapperFunc:ident) => {
        pub unsafe fn $wrapperFunc(arg: $argty) -> String {
            debug_assert!(!arg.is_null());
            let ptr = $llvmFunc(arg);
            raw_to_string(ptr)
        }
    };
}

macro_rules! wrap_maybe_null {
    ($llvmFunc: ident, $argty:ty, $wrapperFunc:ident) => {
        pub unsafe fn $wrapperFunc(arg: $argty) -> Option<String> {
            debug_assert!(!arg.is_null());
            let ptr = $llvmFunc(arg);
            if ptr.is_null() {
                None
            } else {
                Some(raw_to_string(ptr))
            }
        }
    };
}

macro_rules! wrap_with_len {
    ($llvmFunc:ident, $argty:ty, $wrapperFunc:ident) => {
        pub unsafe fn $wrapperFunc(arg: $argty) -> String {
            debug_assert!(!arg.is_null());
            let mut len = 0;
            let ptr = $llvmFunc(arg, &mut len);
            raw_to_string(ptr)
        }
    };
}

macro_rules! wrap_with_len_maybe_null {
    ($llvmFunc:ident, $argty:ty, $wrapperFunc:ident) => {
        pub unsafe fn $wrapperFunc(arg: $argty) -> Option<String> {
            debug_assert!(!arg.is_null());
            let mut len = 0;
            let ptr = $llvmFunc(arg, &mut len);
            if ptr.is_null() {
                None
            } else {
                Some(raw_to_string(ptr))
            }
        }
    };
}

macro_rules! wrap_bool {
    ($llvmFunc:ident, $argty:ty, $wrapperFunc:ident) => {
        pub unsafe fn $wrapperFunc(arg: $argty) -> bool {
            debug_assert!(!arg.is_null());
            let val: i32 = $llvmFunc(arg);
            val != 0
        }
    };
}

wrap_with_len!(LLVMGetModuleInlineAsm, LLVMModuleRef, get_module_inline_asm);
wrap_with_len!(
    LLVMGetModuleIdentifier,
    LLVMModuleRef,
    get_module_identifier
);
wrap_with_len!(LLVMGetSourceFileName, LLVMModuleRef, get_source_file_name);
wrap!(LLVMGetDataLayoutStr, LLVMModuleRef, get_data_layout_str);
wrap_maybe_null!(LLVMGetTarget, LLVMModuleRef, get_target);
wrap_with_len!(LLVMGetValueName2, LLVMValueRef, get_value_name);
wrap_maybe_null!(LLVMGetStructName, LLVMTypeRef, get_struct_name);
wrap_maybe_null!(LLVMGetSection, LLVMValueRef, get_section);
wrap_maybe_null!(LLVMGetGC, LLVMValueRef, get_gc);
wrap!(LLVMGetBasicBlockName, LLVMBasicBlockRef, get_bb_name);
wrap!(LLVMPrintValueToString, LLVMValueRef, print_to_string);
// wrap!(LLVMPrintTypeToString, LLVMTypeRef, print_type_to_string);
wrap_with_len!(
    LLVMGetStringAttributeKind,
    LLVMAttributeRef,
    get_string_attribute_kind
);
wrap_with_len!(
    LLVMGetStringAttributeValue,
    LLVMAttributeRef,
    get_string_attribute_value
);
wrap_with_len_maybe_null!(LLVMGetDebugLocFilename, LLVMValueRef, get_debugloc_filename);
wrap_with_len_maybe_null!(
    LLVMGetDebugLocDirectory,
    LLVMValueRef,
    get_debugloc_directory
);

wrap_bool!(LLVMHasMetadata, LLVMValueRef, has_metadata);

// Panics if the LLVMValueRef is not a basic block
pub unsafe fn op_to_bb(op: LLVMValueRef) -> LLVMBasicBlockRef {
    assert!(LLVMValueIsBasicBlock(op) != 0);
    LLVMValueAsBasicBlock(op)
}

/// LLVM Context wrapper that frees the underlying context when the wrapper is dropped
pub struct Context {
    pub ctx: LLVMContextRef,
}

impl Context {
    pub fn new() -> Self {
        Self {
            ctx: unsafe { LLVMContextCreate() },
        }
    }
}

impl Drop for Context {
    fn drop(&mut self) {
        unsafe {
            LLVMContextDispose(self.ctx);
        }
    }
}
