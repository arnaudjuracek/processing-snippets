import themidibus.*;
void controllerChange(int channel, int number, int value){
	korg.keyPressed = true;
	korg.set(number, value);
}

public class Korg{
	MidiBus bus;
	PApplet parent;

	private final int
		PREVIOUS = 58,
		NEXT = 59,
		CYCLE = 46,
		MARKER_SET = 60,
		MARKER_PREVIOUS = 61,
		MARKER_NEXT = 62,
		BACKWARD = 43,
		FORWARD = 44,
		STOP = 42,
		PLAY = 41,
		REC = 45;
	private final
		int[] S = {32,33,34,35,36,37,38,39};
		int[] M = {48,49,50,51,52,53,54,55};
		int[] R = {64,65,66,67,68,69,70,71};

		boolean[] keys = new boolean[62];
			float[] potar = new float[8];
			float[] slider = new float[8];
			boolean[] s = new boolean[8];
			boolean[] m = new boolean[8];
			boolean[] r = new boolean[8];

	boolean keyPressed = false;
	boolean debug;

	Korg(PApplet parent, boolean... debug){
		this.parent = parent;
		this.debug = (debug.length>0);

		if(this.debug) MidiBus.list();
		this.bus = new MidiBus(parent, "nanoKONTROL2", "nanoKONTROL2");
			this.bus.sendTimestamps(false);

		this.helloWorld();
	}

	void update(){ this.keyPressed = false; }

	void set(int keyCode, float v){
		if(this.debug) println(keyCode + " : " + v);
		if(keyCode>=0 && keyCode<=7) this.slider[keyCode] = map(v, 0, 127, 0, 1);
		if(keyCode>=16 && keyCode<=23) this.potar[keyCode-16] = map(v, 0, 127, 0, 1);
		if(keyCode>=S[0] && keyCode<=S[7]) this.s[keyCode-S[0]] = (v!=0);
		if(keyCode>=M[0] && keyCode<=M[7]) this.m[keyCode-M[0]] = (v!=0);
		if(keyCode>=R[0] && keyCode<=R[7]) this.r[keyCode-R[0]] = (v!=0);

		switch(keyCode){
			case PREVIOUS : this.keys[PREVIOUS] = (v!=0); break;
			case NEXT : this.keys[NEXT] = (v!=0); break;
			case CYCLE : this.keys[CYCLE] = (v!=0); break;
			case MARKER_SET : this.keys[MARKER_SET] = (v!=0); break;
			case MARKER_PREVIOUS : this.keys[MARKER_PREVIOUS] = (v!=0); break;
			case MARKER_NEXT : this.keys[MARKER_NEXT] = (v!=0); break;
			case BACKWARD : this.keys[BACKWARD] = (v!=0); break;
			case FORWARD : this.keys[FORWARD] = (v!=0); break;
			case STOP : this.keys[STOP] = (v!=0); break;
			case PLAY : this.keys[PLAY] = (v!=0); break;
			case REC : this.keys[REC] = (v!=0); break;
		}

		// this.led(keyCode, true);
	}

	void led(int keyCode, boolean state){
		ControlChange cc = new ControlChange(0, keyCode, int(state)*127);
		this.bus.sendControllerChange(cc);
	}

	void lights(boolean state){ for(int i=0; i<127; i++) this.led(i, state); }
	void blink(int times, int delay){
		for(int i=0; i<times; i++){
			delay(delay*.5);
			this.lights(true);
			delay(delay*.5);
			this.lights(false);
		}
	}

	void helloWorld(){
		for(int k=0; k<3; k++){
			for(int i=0; i<8; i++){
				this.lights(false);
				this.led(S[i], true);
				this.led(M[i], true);
				this.led(R[i], true);
				delay(50);
			}
			for(int i=6; i>0; i--){
				this.lights(false);
				this.led(S[i], true);
				this.led(M[i], true);
				this.led(R[i], true);
				delay(50);
			}
		}
		this.lights(false);
		this.led(S[0], true);
		this.led(M[0], true);
		this.led(R[0], true);
		delay(50);
		this.blink(3, 200);
		this.blink(1, 1000);
	}

	boolean keyPressed(int keyCode){ return this.keyPressed ? this.keys[keyCode] : false; }

}

void delay(float time) {
	float current = millis();
	while (millis () < current+time) Thread.yield();
}
