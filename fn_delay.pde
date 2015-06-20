// pause the program for a duration (ms)
void delay(float duration){
	float current = millis();
	while(millis() < current+duration) Thread.yield();
}