fn int_pow(base int, exp int) int {
	mut result := 1
	for i := 0; i < exp; i++ {
		result *= base
	}
	return result
}
