module main

fn evaluate_expression(expr string) ?Expression {
	mut symstack := []Expression{}
	// TODO: There has to be _some_ way to add more meaningful error messages
	for i := expr.len - 1; i >= 0; i-- {
		c := expr[i]
		match c {
			`&` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_and
				}
			}
			`|` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_or
				}
			}
			`!` {
				if symstack.len < 1 {
					return error('Malformed expression at $i -> $c.str()')
				}
				exp := symstack[symstack.len - 1]
				symstack = symstack.slice(0, symstack.len - 1)
				symstack << Expression{
					exps: [exp]
					operator: .op_not
				}
			}
			`=` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_eq
				}
			}
			`>` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_impl
				}
			}
			`<` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_coimpl
				}
			}
			`^` {
				if symstack.len < 2 {
					return error('Malformed expression at $i -> $c.str()')
				}
				expa := symstack[symstack.len - 1]
				expb := symstack[symstack.len - 2]
				symstack = symstack.slice(0, symstack.len - 2)
				symstack << Expression{
					exps: [expa, expb]
					operator: .op_xor
				}
			}
			`T` {
				symstack << Expression{
					operator: .op_top
				}
			}
			`1` {
				symstack << Expression{
					operator: .op_top
				}
			}
			`F` {
				symstack << Expression{
					operator: .op_bottom
				}
			}
			`0` {
				symstack << Expression{
					operator: .op_bottom
				}
			}
			else {
				symstack << Expression{
					name: c.str()
					operator: .op_atom
				}
			}
		}
	}
	if symstack.len == 0 {
		return error('Empty expression!')
	}
	if symstack.len != 1 {
		return error('Multiple expressions left!')
	}
	return symstack[0]
}
