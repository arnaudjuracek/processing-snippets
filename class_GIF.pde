/*
 * class for easy access to the gifAnimation lib (.gif recording)
 *
 * usage :
 * new Gif(PApplet parent, String filename, int quality, int repeat, int duration);
 *
 */

import gifAnimation.*;

class Gif{
	PApplet parent;
	GifMaker gifMaker;
	String filename;
	int frameStart = 0;
	int duration;
	boolean started = false;

	Gif(PApplet parent, String filename, int quality, int repeat, int duration){
		this.parent = parent;
		this.filename = filename;
		this.duration = int(duration * frameRate);
		this.gifMaker = new GifMaker(parent, "gif_export/"+filename+".gif", quality);
		this.gifMaker.setRepeat(repeat);
	}

	void update(){
		if(this.frameStart == 0){
			this.frameStart = frameCount;
			println("Gif started ------------- " + frameCount);
		}

		this.gifMaker.addFrame();
		println("Gif writing : "+ (frameCount - this.frameStart) + "/" + duration);

		if(frameCount-this.frameStart >= duration){
			this.gifMaker.finish();
			println("Gif finished ------------- " + frameCount);
			println("gif_export/"+this.filename+".gif");
			exit();
		}
	}
}