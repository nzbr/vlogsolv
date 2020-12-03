module main

import os

fn main() {
	// TODO: Add proper argument parsing
	enable_condense := true
	verbose := true
	mut expr := ''
	for i, s in os.args {
		if i == 0 { // Skip executable name
			continue
		}
		mut trim := ''
		for _, c in s {
			if c != ` ` {
				trim += c.str()
			}
		}
		expr += trim
	}
	input := format_input(expr)
	println('Input:\t$input')
	expr = to_prefix(expr)
	println('Prefix:\t$expr')
	atoms := get_atoms(expr)
	println('Atoms:\t$atoms')
	println('')
	valuesets := gen_state_arrs(0, atoms.len)
	expression := evaluate_expression(expr) or {
		println(err)
		exit(1)
	}
	if valuesets.len > 0 {
		mut results := []Result{cap: valuesets.len}
		mut allocs_true := [][]Allocation{cap: valuesets.len}
		mut allocs_false := [][]Allocation{cap: valuesets.len}
		for _, values in valuesets {
			mut assignment := map[string]bool{}
			for i, atom in atoms {
				assignment[atom] = values[i]
			}
			result := expression.eval(assignment)
			alloc := bool_to_alloc(values)
			if !enable_condense {
				results << Result{
					assignment: alloc
					result: result
				}
			} else {
				if result {
					allocs_true << alloc
				} else {
					allocs_false << alloc
				}
			}
		}
		if enable_condense {
			for _, alloc in condense(allocs_true) {
				results << Result{
					assignment: alloc
					result: true
				}
			}
			for _, alloc in condense(allocs_false) {
				results << Result{
					assignment: alloc
					result: false
				}
			}
		}
		print_table(atoms, results)
	} else {
		println(expression.eval(map[string]bool{}))
	}
}
