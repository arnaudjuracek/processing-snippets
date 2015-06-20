// return average color from an array of colors
public color COLOR_average(color[] arr){
	color average = arr[0];
	for(int i=0;i<arr.length;i++){
		average = lerpColor(average,arr[i],.5);
	}
	return average;
}

// return brightest color from an array of colors
public color COLOR_brightest(color[] arr){
	color brightest = color(0);
	for(int i=0;i<arr.length;i++){
		if(brightness(arr[i]) > brightness(brightest)) brightest = arr[i];
	}
	return brightest;
}