module main

enum Operator {
	op_and
	op_or
	op_impl
	op_coimpl
	op_eq
	op_xor
	op_not
	op_atom
	op_top
	op_bottom
}

struct Expression {
	exps     []Expression
	name     string
	operator Operator
}

fn (e Expression) eval(vars map[string]bool) bool {
	return match e.operator {
		.op_and    { e.eval_and(vars) }
		.op_atom   { e.eval_atom(vars) }
		.op_bottom { e.eval_bottom(vars) }
		.op_coimpl { e.eval_coimpl(vars) }
		.op_eq     { e.eval_eq(vars) }
		.op_impl   { e.eval_impl(vars) }
		.op_not    { e.eval_not(vars) }
		.op_or     { e.eval_or(vars) }
		.op_top    { e.eval_top(vars) }
		.op_xor    { e.eval_xor(vars) }
		else       { panic_unknown_element() }
	}
}

fn panic_unknown_element() bool {
	panic('Unknown enum element. This should never happen')
}

fn (e Expression) eval_and(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	return a.eval(vars) && b.eval(vars)
}

fn (e Expression) eval_or(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	return a.eval(vars) || b.eval(vars)
}

fn (e Expression) eval_impl(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	va := a.eval(vars)
	vb := b.eval(vars)
	return (!va) || (va && vb)
}

fn (e Expression) eval_coimpl(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	va := a.eval(vars)
	vb := b.eval(vars)
	return (!vb) || (va && vb)
}

fn (e Expression) eval_eq(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	return a.eval(vars) == b.eval(vars)
}

fn (e Expression) eval_xor(vars map[string]bool) bool {
	a  := e.exps[0]
	b  := e.exps[1]
	return a.eval(vars) != b.eval(vars)
}

fn (e Expression) eval_not(vars map[string]bool) bool {
	exp  := e.exps[0]
	return ! exp.eval(vars)
}

fn (e Expression) eval_atom(vars map[string]bool) bool {
	return vars[e.name]
}

fn (e Expression) eval_top(vars map[string]bool) bool {
	return true
}

fn (e Expression) eval_bottom(vars map[string]bool) bool {
	return false
}


