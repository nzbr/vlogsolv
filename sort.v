module main

fn partition(mut nums []string, low, high int) int {
	pivot := nums[high]
	mut i := low - 1
	for j := low; j <= high - 1; j++ {
		if nums[j] < pivot {
			i++
			temp := nums[i]
			nums[i] = nums[j]
			nums[j] = temp
		}
	}
	temp := nums[i + 1]
	nums[i + 1] = nums[high]
	nums[high] = temp
	return i + 1
}

fn quicksort(mut nums []string, low, high int) {
	if low < high {
		pi := partition(mut nums, low, high)
		quicksort(mut nums, low, pi - 1)
		quicksort(mut nums, pi + 1, high)
	}
}
