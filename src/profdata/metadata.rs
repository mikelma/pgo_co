use llvm_sys::{core::*, prelude::*, LLVMTypeKind};

use std::ffi::CStr;

use crate::llvm_utils as utils;

#[derive(Debug)]
pub enum Metadata {
    String(String),
    Node(Vec<Metadata>),

    IntValue(u64),
    FloatValue(f64),
} 

impl Metadata {
    pub fn extract_metadata(value_ref: LLVMValueRef, kind_id: u32) -> Option<Self> {
        // check if the value has any metadata
        if unsafe { !utils::has_metadata(value_ref) } {
            return None;
        }

        let md_ref = unsafe {
            llvm_sys::core::LLVMGetMetadata(value_ref, kind_id)
        };

        if md_ref.is_null() {
            return None;
        }

        Some(Self::from_value_ref(md_ref))
    }

    fn from_value_ref(value_ref: LLVMValueRef) -> Metadata {
        unsafe {
            match LLVMGetTypeKind(LLVMTypeOf(value_ref)) {
                LLVMTypeKind::LLVMFloatTypeKind 
                    | LLVMTypeKind::LLVMDoubleTypeKind => {
                    let mut _lossy = 0; // whether the value has lost any info
                    let constant = LLVMConstRealGetDouble(value_ref, &mut _lossy);

                    Metadata::FloatValue(constant)
                },
                LLVMTypeKind::LLVMIntegerTypeKind => {
                    // Metadata::IntValue(LLVMConstIntGetSExtValue(value_ref))
                    Metadata::IntValue(LLVMConstIntGetZExtValue(value_ref))
                },
                LLVMTypeKind::LLVMMetadataTypeKind => {
                    if Self::is_string(value_ref) {
                        let str_val = Self::get_string_value(value_ref).unwrap();
                        Metadata::String(str_val)

                    } else { // is node
                        let values: Vec<Metadata> = Self::get_node_values(value_ref).iter().map(|&v| Self::from_value_ref(v)).collect();
                        Metadata::Node(values)
                    }
                },
                _ => unimplemented!(),
            }
        }
    }

    fn is_string(value_ref: LLVMValueRef) -> bool {
        return unsafe { LLVMIsAMDString(value_ref) } == value_ref;
    }

    fn is_node(value_ref: LLVMValueRef) -> bool {
        return unsafe { LLVMIsAMDNode(value_ref) } == value_ref;
    }

    fn get_node_size(value_ref: LLVMValueRef) -> u32 {
        if Self::is_string(value_ref) {
            return 0;
        }

        unsafe {
            LLVMGetMDNodeNumOperands(value_ref)
        }
    }

    fn get_string_value(value_ref: LLVMValueRef) -> Option<String> {
        if Self::is_node(value_ref) {
            return None;
        }

        let mut len = 0;
        let c_str = Box::new(unsafe {
            CStr::from_ptr(LLVMGetMDString(value_ref, &mut len))
        });

        // this can panic with an `Utf8Error`
        Some(c_str.to_str().unwrap().into())
    }

    fn get_node_values(value_ref: LLVMValueRef) -> Vec<LLVMValueRef> {
        if Self::is_string(value_ref) {
            return vec![];
        }

        let count = Self::get_node_size(value_ref) as usize; 
        let mut values: Vec<LLVMValueRef> = Vec::with_capacity(count);
        let ptr = values.as_mut_ptr();

        unsafe {
            LLVMGetMDNodeOperands(value_ref, ptr);
            values.set_len(count);
        };

        values
    }
}
