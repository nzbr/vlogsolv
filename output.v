module main

fn print_table(atoms []string, results []Result) {
	// Draw table
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
	for _, result in results {
		row = ''
		for _, atom in result.assignment {
			s := atom.str()
			row += ' $s |'
		}
		row += ' ' + result.result.str() + ' '
		println(row)
	}
}
