module main

import os

fn main() {
	mut expr := ""
	for i, s in os.args {
		if i == 0 { continue } // Skip executable name
		mut trim := ""
		for _, c in s { if c != ` ` { trim += c.str() } }
		expr += trim
	}
	input := format_input(expr)
	println('Input:\t$input')
	expr = to_prefix(expr)
	println('Prefix:\t$expr')
	atoms := get_atoms(expr)
	println('Atoms:\t$atoms')
	println('')


	valuesets := gen_state_arrs(0,atoms.len)
	expression := evaluate_expression(expr)
	function := expression.eval

	//Draw table
	mut row     := ''

	//Draw table header
	for atom in atoms {
		row += ' $atom |'
	}
	row += ' value '
	println(row)

	lastrow := row
	row = ""
	for _, c in lastrow {
		if c == `|` {
			row += '+'
		} else {
			row += '-'
		}
	}
	println(row)

	for _, valueset in valuesets {
		row = ''
		mut assignment := map[string]bool
		values := valueset.arr
		for i, atom in atoms {
			assignment[atom] = values[i]
			if values[i] {
				row += ' 1 |'
			} else {
				row += ' 0 |'
			}
		}
		row += ' ${function(expression, assignment).str()} '
		println(row)
	}
}

fn get_atoms(exp string) []string {
	mut result := []string

	for _, c in exp {
		if !(c in [`&`,`|`,`!`,`=`,`>`,`^`,`(`,`)`,`T`,`F`]) && !(c.str() in result) {
			result << c.str()
		}
	}

	return result
}

fn to_prefix(exp string) string {
	mut opstack := []byte
	mut revout := []byte
	for i := exp.len - 1; i >= 0; i-- {
		chr := exp[i]
		if chr in [`&`,`|`,`=`,`>`,`^`,`)`] { // Push operators to stack (except !)
			opstack << chr
			continue
		} else if chr == `(` { // Pop stack until closing brace
			mut popchr := ` `
			for popchr != `)` {
				popchr = opstack[opstack.len-1]
				opstack = opstack.slice(0, opstack.len-1)
				if popchr != `)` { revout << popchr }
			}
		} else { // Append atom to output
			revout << chr
		}
	}
	// Empty stack
	for opstack.len > 0 {
		revout << opstack[opstack.len-1]
		opstack = opstack.slice(0, opstack.len-1)
	}

	// Invert output
	mut result := ''
	for i := revout.len - 1; i >= 0; i-- {
		result += revout[i].str()
	}
	return result
}

fn format_input(exp string) string{
	mut result := exp
	for sym in ['&', '|', '=', '>', '^'] {
		result = result.replace(sym, ' $sym ')
	}
	return result
}

