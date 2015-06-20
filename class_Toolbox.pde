import peasy.*; //scene
import gifAnimation.*; //gif
import nervoussystem.obj.*; //obj
import controlP5.*; //gui

public class Toolbox{
	PApplet parent;

	public Toolbox(PApplet parent){
		this.parent = parent;
		this.init();
	}

	void init(){}

	void update(){
		if(obj != null) this.obj.update();
		if(scene!= null){
			scene.beginHUD();
			if(gui != null) gui.draw();
			scene.endHUD();
		}else if(gui != null) gui.draw();
		if(ease != null) this.ease.update();
		if(gif != null) this.gif.update();
	}

	//------------------------------

	//math
	//round a up to b

	float roundTo(float a, float b){
		if(b==0) this.err("DIVIDE BY 0");
		return ceil(a/b)*b;
	}

	//array manipulation

	int arraySum(int[] arr){
		int sum = 0;
		for(int i=0;i<arr.length;i++) sum += arr[i];
		return sum;
	}

	float arrayAverage(int[] arr){
		return this.arraySum(arr) / arr.length;
	}

	//debug

	void err(String str){
		println(str);
		exit();
	}

	//------------------------------

	// Allow drag'n'drop rotation/zoom/move on 3D scenes

	void scene(int x, int y, int z, int distance){
		if(scene==null) scene = new Scene(this.parent,x,y,z,distance);
		else scene.set(this.parent,x,y,z,distance);
	}

	Scene scene;
	class Scene{
		PApplet parent;
		PeasyCam cam;

		Scene(PApplet parent, int x, int y, int z, int distance){
			this.set(parent, x, y, z, distance);
			cam.setRightDragHandler(cam.getPanDragHandler());
		}

		void set(PApplet parent, int x, int y, int z, int distance){
			this.cam = new PeasyCam(parent,x,y,z,distance);
		}

		void beginHUD(){
			hint(DISABLE_DEPTH_TEST);
			cam.beginHUD();
		}

		void endHUD(){
			cam.endHUD();
			hint(ENABLE_DEPTH_TEST);
		}
	}

	//------------------------------
	// GUI
	void gui(boolean autohide, int x, int y, int w, int h, color background, String... optionalLabel){
		String label = (optionalLabel.length>0) ? optionalLabel[0] : "";
		gui = new Gui(this.parent, autohide, x, y, w, h, background, label);
	}

	Gui gui;
	class Gui{
		PApplet parent;
		boolean autohide;
		int x, y, w, h;
		color background;
		String label;

		Gui(PApplet parent, boolean autohide, int x, int y, int w, int h, color background, String label){
			this.parent = parent;
			this.autohide = autohide;
			this.x = x;
			this.y = y;
			this.w = w;
			this.h = h;
			this.background = background;
			this.label = label;
		}

		ArrayList<Slider> sliders = new ArrayList<Slider>();
		ArrayList<Button> buttons = new ArrayList<Button>();
		ArrayList<Toggle> toggles = new ArrayList<Toggle>();

		void slider(String valueName, String label, int min, int max, int value, int x, int y, int w, int h){
			this.sliders.add( new Slider(this.parent, valueName, label, min, max, value, this.x+x, this.y+y, w, h) );
		}

		void button(String functionName, String label, int x, int y, int... size){
			int w = (size.length>0) ? size[0] : 10;
			int h = (size.length>0) ? size[1] : 10;
			this.buttons.add( new Button(this.parent, functionName, label, this.x+x, this.y+y, w, h) );
		}

		void toggle(String valueName, String label, boolean value, int x, int y, int... size){
			int w = (size.length>0) ? size[0] : 10;
			int h = (size.length>0) ? size[1] : 10;
			this.toggles.add( new Toggle(this.parent, valueName, label, value, this.x+x, this.y+y, w, h) );
		}

		//------------------------------

		void draw(){
			if(this.autohide) display = (mouseY > this.y && mouseY < this.y+this.h && mouseX > this.x && mouseX < this.x + this.w);

			if(this.display){
				noStroke();
				fill(background);
				rect(x,y,w,h);
				if(this.sliders.size()>0) for(int i=0;i<this.sliders.size();i++) this.sliders.get(i).draw();
				if(this.buttons.size()>0) for(int i=0;i<this.buttons.size();i++) this.buttons.get(i).draw();
				if(this.toggles.size()>0) for(int i=0;i<this.toggles.size();i++) this.toggles.get(i).draw();
			}
		}

		boolean display = true;
		void hide(){ display = false; }
		void show(){ display = true; }

		//------------------------------

		class Slider{
			PApplet parent;
			ControlP5 cp5;

			Slider(PApplet parent, String valueName, String label, int min, int max, int value, int x, int y, int w, int h){
				this.cp5 = new ControlP5(parent);
				this.cp5.addSlider(valueName)
						.setRange(min, max)
						.setValue(value)
						.setLabel(label)
						.setPosition(x,y)
						.setSize(w,h);
				this.cp5.setColorForeground(color(50));
				this.cp5.setColorBackground(color(255));
				this.cp5.setColorLabel(color(255));
				this.cp5.setColorValue(color(255));
				this.cp5.setColorActive( color(50,200,50) );

				PFont p = loadFont("ProFontWindows.vlw");
				this.cp5.setControlFont(p,14);

				this.cp5.setAutoDraw(false);
			}

			void draw(){ cp5.draw(); }
		}

		//------------------------------

		class Button{
			PApplet parent;
			ControlP5 cp5;

			Button(PApplet parent, String functionName, String label, int x, int y, int w, int h){
				this.cp5 = new ControlP5(parent);
				this.cp5.addButton(functionName)
						.setPosition(x,y)
						.setLabel(label)
						.setSize(w,h);
				this.cp5.setColorForeground(color(50));
				this.cp5.setColorBackground(color(255));
				this.cp5.setColorLabel(color(255));
				this.cp5.setColorValue(color(255));
				this.cp5.setColorActive( color(200,50,50) );;
				this.cp5.getController(functionName).getCaptionLabel().getStyle()
				  .setPadding(0,0,0,0)
				  .setMargin(0,0,0,w);

				PFont p = loadFont("ProFontWindows.vlw");
				this.cp5.setControlFont(p,14);

				this.cp5.setAutoDraw(false);
			}

			void draw(){ cp5.draw(); }
		}

		//------------------------------

		class Toggle{
			PApplet parent;
			ControlP5 cp5;

			Toggle(PApplet parent, String valueName, String label, boolean value, int x, int y, int w, int h){
				this.cp5 = new ControlP5(parent);
				this.cp5.addToggle(valueName)
						.setValue(value)
						.setLabel(label)
						.setPosition(x,y)
						.setSize(w,h);
				this.cp5.setColorForeground(color(50));
				this.cp5.setColorBackground(color(255));
				this.cp5.setColorLabel(color(255));
				this.cp5.setColorValue(color(255));
				this.cp5.setColorActive( color(50,50,200) );
				this.cp5.getController(valueName).getCaptionLabel().getStyle()
				  .setPadding(0,0,0,0)
				  .setMargin(-(h+3),0,0,h+4);

				PFont p = loadFont("ProFontWindows.vlw");
				this.cp5.setControlFont(p,14);

				this.cp5.setAutoDraw(false);
			}

			void draw(){ cp5.draw(); }
		}

	  }

  //------------------------------

	// GIF export

	void gif(String filename, int quality, int repeat, int duration){ this.gif = new Gif(this.parent, filename, quality, repeat, duration); }

	Gif gif;
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

  //------------------------------

	// OBJ export

	void obj(String filename, boolean useColor){ this.obj = new Obj(filename, useColor); }

	Obj obj;
	class Obj{
		// OBJExport obj;
		String filename;
		boolean record = false;

		Obj(String filename, boolean useColor){
			beginRecord("nervoussystem.obj.OBJExport","obj_export/"+filename+".obj");
			this.filename = filename;
			this.record = true;
			println("Obj started ------------- " + frameCount);
		}

		void update(){
			if(this.record){
				endRecord();
				this.record = false;
				println("Obj finished ------------- " + frameCount);
				println("obj_export/"+this.filename+".obj");
			}
		}
	}

  //------------------------------

	// easing
	Ease ease;
	void ease(float defaultEasing, boolean... d){ ease = new Ease(this.parent, defaultEasing, (d.length>0) ? d[0] : false); }

	class Ease{
		PApplet parent;
		ArrayList<Value> values = new ArrayList<Value>();
		float defaultEasing;
		boolean debug;

		Ease(PApplet parent, float defaultEasing, boolean debug){
			this.parent = parent;
			this.defaultEasing = defaultEasing;
			this.debug = debug;
		}

		void set(String name, float value, float... e){
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name){
					v.targetValue = value;
					v.easing = (e.length>0) ? e[0] : v.easing;
					if(this.debug) println(name+" : value set to "+value);
					return;
				}
			}
			this.define(name, value, (e.length>0) ? e[0] : this.defaultEasing);
		}

		boolean setEasing(String name, float easing){
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name){
					if(this.debug) println(name+" : easing set to "+easing+" (previous = "+v.easing+")");
					v.easing = easing;
					return true;
				}
			}
			if(this.debug) println(name+" not defined");
			return false;
		}

		void define(String name, float value, float easing){
			if(this.debug) println(name+" not defined :\nnew "+name+" set to "+value+" with "+easing+" easing");
			values.add( new Value(name, value, easing) );
		}

		float get(String name){
			float rtrn = 0.0;
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name) rtrn = v.value;
			}
			return rtrn;
		}

		void update(){ for(int i=0; i<this.values.size();i++) this.values.get(i).update(); }

		class Value{
			String name;
			float
				value = 0,
				targetValue,
				easing;

			Value(String name, float value, float easing){
				this.name = name;
				this.targetValue = value;
				this.easing = easing;
			}

			void update(){
				float d = this.targetValue - this.value;
				if(abs(d)>1) this.value += d * easing;
			}
		}

	}

  //------------------------------

	//shader
	//shaders
	void shader_ascii(int q, int fs, boolean f){
		String[] cc = {
			"█▓▒▒▒░ ",
			"@#*+=:-. ",
			"M#E8Oo+i=I;:~.` ",
			"$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. ",
			"@N%Q&WMgm$0BDRH#8dObUAqhGwKpXk9V6P]Eyun[41ojae2S5YfZx(lI)F3{CtJviT7srz\\Lc/?*!+<;^=\",:_'.-` "};
			String c = cc[ q<cc.length ? q<0 ? 0 : q : cc.length-1];
			textSize(fs);

		if(toolbox.scene != null) toolbox.scene.beginHUD();

			loadPixels();
			noLights();
			background(10);
			fill(255);
			colorMode(HSB);

			for(int y=0; y<height;y+=fs){
				for(int x=0; x<width;x+=fs){
					int i = x + y*width;
					float b = brightness(pixels[i]);
					if(f) fill(hue(pixels[i]),saturation(pixels[i]),255);
					int bi = int(map(b,255,0,0,c.length()-1));
					text(c.charAt(bi),x,y);
				}
			}

			colorMode(RGB);

		if(toolbox.scene != null) toolbox.scene.endHUD();
	}

  //------------------------------
	// more

}