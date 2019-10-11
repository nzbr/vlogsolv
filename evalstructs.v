module main

struct Expression {
	exps      []Expression
	name string
	eval      fn(Expression, map[string]bool) bool
}

fn eval_and(e Expression, vars map[string]bool) bool {
	expa  := e.exps[0]
	evala := expa.eval
	expb  := e.exps[1]
	evalb := expb.eval
	return evala(expa, vars) && evalb(expb, vars)
}

fn eval_or(e Expression, vars map[string]bool) bool {
	expa  := e.exps[0]
	evala := expa.eval
	expb  := e.exps[1]
	evalb := expb.eval
	return evala(expa, vars) || evalb(expb, vars)
}

fn eval_not(e Expression, vars map[string]bool) bool {
	exp  := e.exps[0]
	eval := exp.eval
	return ! eval(exp, vars)
}

fn eval_atom(e Expression, vars map[string]bool) bool {
	return vars[e.name]
}

fn eval_true(e Expression, vars map[string]bool) bool {
	return true
}

fn eval_false(e Expression, vars map[string]bool) bool {
	return false
}


