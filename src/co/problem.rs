use crate::profdata::{Function, Metadata};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct CoProblem {
    pub c: Vec<Vec<u64>>,
    pub s: Vec<usize>,
    pub n: usize,
}

impl CoProblem {
    pub fn eval(&self, solution: &[usize]) -> u64 {
        // original: let s_sum = self.s.iter().fold(0, |sum, v| sum + v);
        let s_sum: usize = self.s.iter().sum();
        // println!("s_sum: {s_sum}");

        let mut f = 0;
        for i in 0..self.n {
            for j in (i + 1)..self.n {
                let interaction =
                    self.c[solution[i]][solution[j]] + self.c[solution[j]][solution[i]];
                // original: let distance = self.s[i..j + 1].iter().fold(0, |sum, v| sum + (s_sum - v));
                // let distance = self.s[i..j + 1].iter().sum::<usize>();
                let mut distance = 0;
                for k in i..(j + 1) {
                    distance += self.s[solution[k]];
                }
                // println!("i={i}, j={j}, interaction={interaction}, dist(norev)={distance}");
                // original: f += interaction * distance as u64;
                f += interaction * (s_sum - distance) as u64;
            }
        }

        return f;
    }

    pub fn block_reordering_from(function: &Function) -> Option<Self> {
        if function.bbs_branch_tree[0].is_empty() {
            return None;
        }

        let num_blocks = function.num_bbs;
        let mut c = vec![vec![0; num_blocks]; num_blocks];

        let mut no_md_branches = vec![];

        for i in 0..num_blocks {
            // if the basic block has some branch metadata
            if let Some(Some(Metadata::Node(leafs))) = function.bb_terminator_md.get(i) {
                let mut leafs_iter = leafs.iter();

                // extract branch metadata
                let branch_weights: Vec<u64> = match leafs_iter.next() {
                    Some(Metadata::String(name)) if name == "branch_weights" => leafs_iter
                        .map(|v| match v {
                            Metadata::IntValue(w) => *w,
                            _ => unreachable!(),
                        })
                        .collect(),
                    _ => continue,
                };

                // set the weight of each branch
                for (j, neighbor_idx) in function.bbs_branch_tree[i].iter().enumerate() {
                    c[i][*neighbor_idx] = branch_weights[j];
                }
            } else {
                // there is no metadata for the branches
                // take the branch weight as the sum of all branchs weights to this basic block

                for neighbor_idx in function.bbs_branch_tree[i].iter() {
                    no_md_branches.push((i, *neighbor_idx))
                }
            }
        }

        // for each missing branch
        for (br_from, br_to) in no_md_branches.clone() {
            c[br_from][br_to] = Self::fill_missing_branch_weights(
                &c,
                br_from,
                &mut no_md_branches,
                &function.bbs_branch_tree,
                0,
                num_blocks,
            );
        }

        // TODO: Optimize
        // remove the data referring to the entry basic block, as
        // it dosn't take part in the optimization problem
        let s = function.bbs_num_instrs[1..num_blocks].to_vec();
        c.remove(0);
        c.iter_mut().for_each(|row| {
            let _ = row.remove(0);
        });

        Some(CoProblem {
            c,
            s,
            n: num_blocks - 1,
        })
    }

    fn fill_missing_branch_weights(
        c: &Vec<Vec<u64>>,
        br_from: usize,
        missing_branches: &mut Vec<(usize, usize)>,
        branch_tree: &Vec<Vec<usize>>,
        recursion_depth: usize,
        max_recursion: usize,
    ) -> u64 {
        if recursion_depth > max_recursion {
            return 0;
        }

        // get the index of each basic block that calls `br_from`
        let parents = branch_tree
            .iter()
            .enumerate()
            .filter(|(_, v)| v.contains(&br_from))
            .map(|(i, _)| i)
            .collect::<Vec<usize>>();

        let mut sum: u64 = 0;

        for parent in parents {
            if missing_branches.contains(&(parent, br_from)) {
                sum += Self::fill_missing_branch_weights(
                    c,
                    parent,
                    missing_branches,
                    branch_tree,
                    recursion_depth + 1,
                    max_recursion,
                );

                // note: the missing branch could be removed in the recursive call above
                // that's why there's an `if let` here
                if let Some(idx) = missing_branches
                    .iter()
                    .position(|v| *v == (parent, br_from))
                {
                    missing_branches.remove(idx);
                }
            } else {
                sum += c[parent][br_from];
            }
        }

        return sum;
    }

    /// Returns `true` if the sum of all elements of the `C` matrix of the `CoProblem` is zero.
    pub fn is_zeros(&self) -> bool {
        self.c
            .iter()
            .find(|row| row.iter().sum::<u64>() != 0)
            .is_none()
    }
}
