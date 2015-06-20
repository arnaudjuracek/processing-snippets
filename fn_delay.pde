void delay(float time) {
	float current = millis();
	while (millis () < current+time) Thread.yield();
}