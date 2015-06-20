// return the sum of an array
int ARRAY_sum(int[] arr){
	int sum = 0;
	for(int i=0;i<arr.length;i++) sum += arr[i];
	return sum;
}

// return the average of an array
float ARRAY_average(int[] arr){
	return this.arraySum(arr) / arr.length;
}