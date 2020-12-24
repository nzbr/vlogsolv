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
