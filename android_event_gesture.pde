/*
 * functions for handling gestures on Android tactile systems
 *
 * usage :
 * KetaiGesture GESTURE;
 * GESTURE = new KetaiGesture(parent);
 *
 */

import android.view.MotionEvent;
import ketai.ui.*;

// KETAI ----------

	void onDoubleTap(float x, float y){}
	void onTap(float x, float y){}
	void onLongPress(float x, float y){}
	void onPinch(float x, float y, float d){}
	void onRotate(float x, float y, float ang){}
	// void onFlick(float x, float y, float px, float py, float v){}

// CUSTOM ---------

	// these following functions are called in the Ketai's onFlick(),
	// which you can overide to use as it is.
	void onFlick_up(PVector pos, PVector p_pos){}
	void onFlick_down(PVector pos, PVector p_pos){}
	void onFlick_left(PVector pos, PVector p_pos){}
	void onFlick_right(PVector pos, PVector p_pos){}

	// the coordinates of the start of the gesture, end of gesture and velocity in pixels/sec
	void onFlick(float x, float y, float px, float py, float v){
		// the constant for the flick_min_dist is 25dip
			// @see http://stackoverflow.com/questions/11922494/whats-the-default-minimum-distance-to-sucessfully-swipe-in-view-pager
			// @see http://stackoverflow.com/questions/2025282/difference-between-px-dp-dip-and-sp-in-android
			// @see http://stackoverflow.com/questions/8399184/convert-dip-to-px-in-android

		int
			flick_min_velocity = 200,
			flick_min_distance = 120;

		float
			d_x = px - x,
			d_y = py - y;

		PVector
			pos = new PVector(x, y),
			p_pos = new PVector(px, py);

		if(v>=flick_min_velocity){
			if(abs(d_x) >= flick_min_distance && abs(d_x) > abs(d_y)){
				// horizontal flick
				if(d_x > 0) onFlick_left(pos, p_pos);
				else onFlick_right(pos, p_pos);
			}else if(abs(d_y) >= flick_min_distance && abs(d_y) >= abs(d_x)){
				// vertical flick
				if(d_y > 0) onFlick_up(pos, p_pos);
				else onFlick_down(pos, p_pos);
			}
		}
	}

// PROCESSING -----

	// these still work if we forward MotionEvents below
	void mouseDragged(){}
	void mousePressed(){}

	public boolean surfaceTouchEvent(MotionEvent event){
		// call to keep mouseX, mouseY, etc updated
		super.surfaceTouchEvent(event);
		// forward event to class for processing
		return GESTURE.surfaceTouchEvent(event);
	}