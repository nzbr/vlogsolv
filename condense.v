module main

fn singlediff(a []Allocation, b []Allocation) ?int {
	if a.len != b.len {
		return error('len mismatch')
	}
	mut diff := false
	mut pos := -1
	for i := 0; i < a.len; i++ {
		if a[i] != b[i] {
			if diff {
				return error('more than one difference')
			}
			pos = i
			diff = true
		}
	}
	if pos == -1 {
		return error('no difference found')
	}
	return pos
}

fn equal(a []Allocation, b []Allocation) bool {
	if a.len != b.len {
		return false
	}
	for i := 0; i < a.len; i++ {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

fn condense_and_merge(t [][]Allocation, f [][]Allocation) []Result {
	mut tc := condense(t)
	mut fc := condense(f)
	return merge(mut tc, mut fc)
}

fn condense(arr [][]Allocation) [][]Allocation {
	mut next := [][]Allocation{}
	mut matched := [false].repeat(arr.len)
	for i := 0; i < arr.len; i++ {
		for j := i; j < arr.len; j++ {
			pos := singlediff(arr[i], arr[j]) or { continue }
			mut newsol := arr[i].clone()
			newsol[pos] = .al_any
			matched[i] = true
			matched[j] = true
			mut append := true
			for k := 0; k < next.len; k++ {
				if equal(newsol, next[k]) {
					append = false
					break
				}
			}
			if append {
				next << newsol
			}
		}
	}
	if next.len == 0 {
		return arr
	}
	for i := 0; i < matched.len; i++ {
		if !matched[i] {
			next << arr[i]
		}
	}
	return condense(next)
}

fn merge(mut t [][]Allocation, mut f [][]Allocation) []Result {
	t.reverse_in_place()
	f.reverse_in_place()
	mut result := []Result{cap: f.len + t.len}
	for t.len > 0 && f.len > 0 {
		if t[t.len - 1].to_int() >= f[f.len - 1].to_int() {
			result << Result{
				assignment: t.pop()
				result: true
			}
		} else {
			result << Result{
				assignment: f.pop()
				result: false
			}
		}
	}
	for (t.len > 0) {
		result << Result{
			assignment: t.pop()
			result: true
		}
	}
	for (f.len > 0) {
		result << Result{
			assignment: f.pop()
			result: false
		}
	}
	return result
}

fn (self []Allocation) to_int() int {
	mut result := 0
	for i := self.len - 1; i >= 0; i-- {
		result += self[i].to_int() * int_pow(3, (self.len - 1 - i))
	}
	return result
}
