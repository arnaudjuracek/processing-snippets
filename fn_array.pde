// return the sum of an array
public int ARRAY_sum(int[] arr){
	int sum = 0;
	for(int i=0;i<arr.length;i++) sum += arr[i];
	return sum;
}

// return the average of an array
public float ARRAY_average(int[] arr){
	return this.arraySum(arr) / arr.length;
}