use llvm_sys as llvm;

use llvm::core::*;
use llvm::prelude::*;
use llvm::LLVMOpcode;

use super::llvm_utils as utils;
use super::Metadata;

#[derive(Debug)]
pub struct Function {
    pub name: String,
    pub entry_md: Option<Metadata>,
    pub bb_terminator_md: Vec<Option<Metadata>>,
}

impl Function {
    pub fn from_llvm_ref(fn_ref: LLVMValueRef, kind_id: u32) -> Function {
        let name = unsafe { utils::get_value_name(fn_ref) };

        let entry_md = Metadata::extract_metadata(fn_ref, kind_id);

        let bbs_refs = utils::get_basic_blocks(fn_ref);
        let mut bb_terminator_md = vec![];
        for bb_ref in bbs_refs {
            let term = unsafe { LLVMGetBasicBlockTerminator(bb_ref) };

            bb_terminator_md.push(
                if unsafe { LLVMGetInstructionOpcode(term) } == LLVMOpcode::LLVMBr {
                    Metadata::extract_metadata(term, kind_id)
                } else {
                    None
                },
            );
        }

        Function {
            name,
            entry_md,
            bb_terminator_md,
        }
    }

    /*
    fn bbs_first_pass(
        bb: LLVMBasicBlockRef,
        counter: &mut usize,
        ctx: &Context
    ) -> (String, Vec<(LLVMValueRef, String)>) {
        let name = Self::name_or_num(unsafe { utils::get_bb_name(bb) }, counter);
        let mut instructions = vec![];

        for inst in
            utils::all_but_last(utils::get_instructions(bb)).filter(|&i| Self::needs_name(i))
        {
            instructions.push((
                inst,
                Self::name_or_num(unsafe { utils::get_value_name(inst) }, counter),
            ));
        }

        let term = unsafe { LLVMGetBasicBlockTerminator(bb) };

        if Self::term_needs_name(term) {
            instructions.push((
                term,
                Self::name_or_num(unsafe { utils::get_value_name(term) }, counter),
            ));
        }

        dbg!(Self::get_terminator_metadata(term, ctx));

        (name, instructions)
    }

    fn needs_name(inst: LLVMValueRef) -> bool {
        if unsafe { utils::get_value_name(inst) != "" } {
            return true; // has a string name
        }
        match unsafe { LLVMGetInstructionOpcode(inst) } {
            LLVMOpcode::LLVMStore => false,
            LLVMOpcode::LLVMFence => false,
            LLVMOpcode::LLVMCall => {
                // needs a name unless we're calling a void function
                let kind =
                    unsafe { LLVMGetTypeKind(LLVMGetReturnType(LLVMGetCalledFunctionType(inst))) };
                kind != LLVMTypeKind::LLVMVoidTypeKind
            }
            _ => true, // all other instructions have results (destinations) and thus will need names
        }
    }

    fn name_or_num(s: String, ctr: &mut usize) -> String {
        if s != "" {
            s
        } else {
            let rval = format!("{}", ctr);
            *ctr += 1;
            rval
        }
    }

    fn term_needs_name(term: LLVMValueRef) -> bool {
        if unsafe { utils::get_value_name(term) != "" } {
            return true; // has a string name
        }
        match unsafe { LLVMGetInstructionOpcode(term) } {
            LLVMOpcode::LLVMInvoke => true,
            LLVMOpcode::LLVMCatchSwitch => true,
            LLVMOpcode::LLVMCallBr => true,
            _ => false, // all other terminators have no result (destination) and thus don't need names
        }
    }
    */
}
