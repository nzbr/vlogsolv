module main

fn evaluate_expression(expr string) Expression {
	mut symstack := []Expression
	for i := expr.len - 1; i >= 0; i-- {
		c := expr[i]
		match c {
			`&` => {
				if symstack.len < 2 { panic('Malformed expression at $i -> $c') }
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression { exps: [expa, expb], eval: eval_and }
			}
			`|` => {
				if symstack.len < 2 { panic('Malformed expression at $i -> $c') }
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression { exps: [expa, expb], eval: eval_or }
			}
			`!` => {
				if symstack.len < 1 { panic('Malformed expression at $i -> $c') }
				exp := symstack[symstack.len - 1]
				symstack = symstack.slice(0, symstack.len - 1)
				symstack << Expression { exps: [exp], eval: eval_not }
			}
			`T` => {
				symstack << Expression { eval: eval_true }
			}
			`F` => {
				symstack << Expression { eval: eval_false }
			}
			else => {
				symstack << Expression { name: c.str(), eval: eval_atom }
			}
		}
	}
	if symstack.len == 0 { panic('Empty expression!') }
	if symstack.len != 1 { panic('Multiple expressions left!') }
	return symstack[0]
}

