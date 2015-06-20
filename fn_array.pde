import java.util.Random;

// return the sum of an array
public int ARRAY_sum(int[] arr){
	int s = 0;
	for(int a : arr) s += a;
	return s;
}
public float ARRAY_sum(float[] arr){
	float s = 0;
	for(float a : arr) s += a;
	return s;
}


// return the average of an array
public float ARRAY_average(int[] arr){
	int s = 0;
	for(int a : arr) s += a;
	return (s / arr.length);
}
public float ARRAY_average(float[] arr){
	float s = 0;
	for(float a : arr) s += a;
	return (s / arr.length);
}


// shuffle
public int[] ARRAY_shuffle(int[] arr){
	int index;
	Random random = new Random();
	for(int i=arr.length-1; i>0; i--){
		index = random.nextInt(i+1);
		if(index != i){
			arr[index] ^= arr[i];
			arr[i] ^= arr[index];
			arr[index] ^= arr[i];
		}
	}
	return arr;
}
// public float[] ARRAY_shuffle(float[] arr){
// 	int index;
// 	Random random = new Random();
// 	for(int i=arr.length-1; i>0; i--){
// 		index = random.nextInt(i+1);
// 		if(index != i){
// 			arr[index] ^= arr[i];
// 			arr[i] ^= arr[index];
// 			arr[index] ^= arr[i];
// 		}
// 	}
// 	return arr;
// }