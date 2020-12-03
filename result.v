module main

enum Allocation {
	al_true
	al_false
	al_any
}

struct Result {
	assignment []Allocation
	result     bool
}

fn bool_to_alloc(arr []bool) []Allocation {
	mut result := []Allocation{cap: arr.len}
	for _, val in arr {
		if val {
			result << .al_true
		} else {
			result << .al_false
		}
	}
	return result
}

fn (self Allocation) str() string {
	return match self {
		.al_true { '1' }
		.al_false { '0' }
		.al_any { '*' }
	}
}
