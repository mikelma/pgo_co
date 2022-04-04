use rand::seq::SliceRandom;
use super::CoProblem;

use std::collections::VecDeque;

pub fn construct_solution(problem: &CoProblem) -> Vec<usize> {
    let mut solution = VecDeque::with_capacity(problem.n);

    let max_size = problem.s.iter().sum::<usize>() as u64;
    let mut rng = rand::thread_rng();

    let mut push_front = false;

    let mut ordered_by_interaction_tmp = problem.c.iter() 
        .enumerate()
        .collect::<Vec<(usize, &Vec<u64>)>>();

    ordered_by_interaction_tmp.sort_by(|a, b| {
        a.1.iter().sum::<u64>()
            .cmp(&b.1.iter().sum::<u64>())
            .reverse()
    });

    let ord_by_interact = ordered_by_interaction_tmp.iter().map(|(i, _)| *i).collect::<Vec<usize>>();

    while solution.len() < problem.n {
        // get the interaction list and size of the non selected items
        let non_selected = (0..problem.n)
            .filter(|idx| !solution.contains(idx))
            .map(|idx| (idx, problem.c[idx].as_slice(), problem.s[idx]))
            .collect::<Vec<(usize, &[u64], usize)>>();

        // get the weigths of the non selected items
        // list of: (weight, (index, c_list))
        let non_selected_with_weights = non_selected.iter()
            .map(|(idx, c, _)| (ord_by_interact[*idx].pow(2), (*idx, *c)))
            .collect::<Vec<(usize, (usize, &[u64]))>>();
        
        let (_, parent) = non_selected_with_weights
            .choose_weighted(&mut rng, |s| s.0)
            .unwrap();

        if push_front {
            solution.push_front(parent.0);
        } else {
            solution.push_back(parent.0);
        }
        push_front = !push_front;

        // get the children blocks of the most interactive item
        // vector of: (child_id, call_freq_from_parent_to_child)
        let mut children = parent.1.iter()
            .enumerate()
            .filter(|(idx, v)| **v > 0 && !solution.contains(idx))
            // also consider call frequency from child to parent
            .map(|(child_id, v)| (child_id, v + problem.c[child_id][parent.0]))
            .collect::<Vec<(usize, u64)>>();

        // sort children by: children_size*calls_parent2child
        children.sort_by(|(a_idx, a_c), (b_idx, b_c)| {
            let a = a_c*(max_size - problem.s[*a_idx] as u64);
            let b = b_c*(max_size - problem.s[*b_idx] as u64);
            a.cmp(&b).reverse()
        });

        // contains: (child_index, child_weight)
        let mut children_weights = (0..children.len())
            .map(|i| (i, (children.len() - i).pow(2)))
            .collect::<Vec<(usize, usize)>>();

        while !children_weights.is_empty() {

            let (sel_idx, (child_index, _w)) = children_weights.iter()
                .map(|(id, w)| (*id, *w))
                .enumerate()
                .collect::<Vec<(usize, (usize, usize))>>()
                .choose_weighted(&mut rng, |s| s.1.1)
                .map(|v| *v)
                .unwrap();

            children_weights.remove(sel_idx);

            if push_front {
                solution.push_front(children[child_index].0);
            } else {
                solution.push_back(children[child_index].0);
            }
            push_front = !push_front;
        }
    }

    solution.into()
}
