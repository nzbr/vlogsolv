module main

//fn gen_states(vars []string) []map[string]bool {}

struct BoolArr {
	arr []bool
}

fn gen_state_arrs(pos, length int) []BoolArr {
	max := length - 1
	if pos == max {
		mut arr := []BoolArr
		arr << BoolArr{ arr: [true] }
		arr << BoolArr{ arr: [false] }
		return arr
	}
	arrs := gen_state_arrs(pos + 1, length)
	mut newarrs := []BoolArr
	for _, arr in arrs {
		mut t := arr.arr.clone()
		mut f := arr.arr.clone()
		t << true
		f << false
		newarrs << BoolArr{ arr: t }
		newarrs << BoolArr{ arr: f }
	}
	return newarrs
}

fn (b &BoolArr) str() string {
	return b.arr.str()
}
