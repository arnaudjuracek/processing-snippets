/*
 * class for easy acces to the peasy lib (3D scene manipulation)
 *
 * usage :
 * new Scene(PApplet parent, int x, int y, int z, int distance);
 *
 */

import peasy.*;

public class Scene{
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