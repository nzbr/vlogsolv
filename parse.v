module main

fn get_atoms(exp string) []string {
	mut result := []string{}
	for _, c in exp {
		if !(c in [`&`, `|`, `!`, `=`, `>`, `<`, `^`, `(`, `)`, `T`, `F`, `1`, `0`]) && !(c.str() in
			result) {
			result << c.str()
		}
	}
	quicksort(mut result, 0, (result.len - 1))
	return result
}

fn to_prefix(exp string) string {
	mut opstack := []byte{}
	mut revout := []byte{}
	for i := exp.len - 1; i >= 0; i-- {
		chr := exp[i]
		if chr in [`&`, `|`, `=`, `>`, `<`, `^`, `)`] { // Push operators to stack (except !)
			opstack << chr
			continue
		} else if chr == `(` { // Pop stack until closing brace
			mut popchr := ` `
			for popchr != `)` {
				popchr = opstack[opstack.len - 1]
				opstack = opstack.slice(0, opstack.len - 1)
				if popchr != `)` {
					revout << popchr
				}
			}
		} else { // Append atom to output
			revout << chr
		}
	}
	// Empty stack
	for opstack.len > 0 {
		revout << opstack[opstack.len - 1]
		opstack = opstack.slice(0, opstack.len - 1)
	}
	// Invert output
	mut result := ''
	for i := revout.len - 1; i >= 0; i-- {
		result += revout[i].str()
	}
	return result
}

fn format_input(exp string) string {
	mut result := exp
	for sym in ['&', '|', '=', '>', '<', '^'] {
		result = result.replace(sym, ' $sym ')
	}
	return result
}
