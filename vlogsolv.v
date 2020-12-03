module main

import os

fn main() {
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
		exit(1)}
	mut row := ''
	// Draw table header
	for atom in atoms {
		row += ' $atom |'
	}
	row += ' value '
	println(row)
	lastrow := row
	row = ''
	for _, c in lastrow {
		if c == `|` {
			row += '+'
		} else {
			row += '-'
		}
	}
	println(row)
	for _, values in valuesets {
		row = ''
		mut assignment := map[string]bool{}
		for i, atom in atoms {
			assignment[atom] = values[i]
			if values[i] {
				row += ' 1 |'
			} else {
				row += ' 0 |'
			}
		}
		row += ' ${expression.eval(assignment).str()} '
		println(row)
	}
	if valuesets.len == 0 { // If there are no atoms, just calculate the expressions value
		assignment := map[string]bool{}
		println(' ${expression.eval(assignment).str()} ')
	}
	}
}
