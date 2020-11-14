module main

fn gen_state_arrs(pos, length int) [][]bool {
	if length == 0 {
		return [][]bool{ len: 0 }
	}
	max := length - 1
	if pos == max {
		mut arr := [][]bool{}
		arr << [true]
		arr << [false]
		return arr
	}
	arrs := gen_state_arrs(pos + 1, length)
	mut newarrs := [][]bool{}
	for _, arr in arrs {
		mut t := arr.clone()
		mut f := arr.clone()
		t << true
		f << false
		newarrs << t
		newarrs << f
	}
	return newarrs
}
