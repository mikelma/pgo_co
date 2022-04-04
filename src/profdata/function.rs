use llvm_sys as llvm;

use llvm::core::*;
use llvm::prelude::*;
use llvm::LLVMOpcode;

use super::Metadata;
use crate::llvm_utils as utils;

#[derive(Debug)]
pub struct Function {
    pub name: String,
    pub entry_md: Option<Metadata>,
    pub bb_terminator_md: Vec<Option<Metadata>>,
    pub num_bbs: usize,
    pub function_ref: LLVMValueRef,
    pub bbs_branch_tree: Vec<Vec<usize>>,
    pub bbs_num_instrs: Vec<usize>,
}

impl Function {
    pub fn from_llvm_ref(fn_ref: LLVMValueRef, kind_id: u32) -> Function {
        let name = unsafe { utils::get_value_name(fn_ref) };

        let entry_md = Metadata::extract_metadata(fn_ref, kind_id);

        let bbs_refs: Vec<LLVMBasicBlockRef> = utils::get_basic_blocks(fn_ref).collect();

        let num_bbs = bbs_refs.len();
        let mut branch_tree: Vec<Vec<usize>> = vec![vec![]; num_bbs];
        let mut bbs_num_instrs = vec![];

        let mut bb_terminator_md = vec![];
        for (i, bb_ref) in bbs_refs.iter().enumerate() {
            // count the number of instructions in the block
            let mut num_instr = 1;
            unsafe {
                let mut instr = LLVMGetFirstInstruction(*bb_ref);
                loop {
                    instr = LLVMGetNextInstruction(instr);
                    if instr.is_null() {
                        break;
                    }
                    num_instr += 1;
                }
            }

            bbs_num_instrs.push(num_instr);

            let term = unsafe { LLVMGetBasicBlockTerminator(*bb_ref) };

            // extract terminator instruction's metadata
            if unsafe { LLVMGetInstructionOpcode(term) } == LLVMOpcode::LLVMBr {
                bb_terminator_md.push(Metadata::extract_metadata(term, kind_id));

                // get the parent of the current basick block
                let num_operands = unsafe { LLVMGetNumOperands(term) } as u32;
                // the first operand of the `br` instruction is skipped when it refers to the
                // condition value of the branch operation
                let start_idx = if num_operands > 1 { 1 } else { 0 };
                // NOTE: for some reason `rev` has to be used to read the operands
                // in the same order as in the LLVM-IR
                for op_idx in (start_idx..num_operands).rev() {
                    let bb_to_jump = unsafe { LLVMValueAsBasicBlock(LLVMGetOperand(term, op_idx)) };
                    branch_tree[i].push(bbs_refs.iter().position(|&bb| bb == bb_to_jump).unwrap());
                }
            } else {
                bb_terminator_md.push(None);
            }
        }

        Function {
            name,
            entry_md,
            bb_terminator_md,
            num_bbs,
            function_ref: fn_ref,
            bbs_branch_tree: branch_tree,
            bbs_num_instrs,
        }
    }

    pub fn get_entry_count(&self) -> Option<u64> {
        // check if the `entry_md` of the function is a metadata node
        if let Some(Metadata::Node(nodes)) = &self.entry_md {
            let mut it = nodes.iter();

            // get the string that indicates the name of the metadata
            if let Some(Metadata::String(str_data)) = it.next() {
                if str_data == "function_entry_count" {
                    match it.next() {
                        Some(Metadata::IntValue(data)) => {
                            return Some(*data);
                        }
                        _ => unreachable!(),
                    }

                    // the metadata node doesn't contain the info we want
                }
            }
        }
        None
    }

    pub fn get_id(&self) -> String {
        unsafe {
            let mut len = 0;
            let ptr = LLVMGetValueName2(self.function_ref, &mut len);

            utils::raw_to_string(ptr)
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
