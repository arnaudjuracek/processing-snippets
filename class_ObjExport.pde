/*
 * class for easy access to the nervoussystem lib objExport
 *
 * usage :
 * new ObjExport(String filename);
 *
 * call ObjExport.update(); at the end of the draw() to update all the recording.
 */

import nervoussystem.obj.*;

class ObjExport{
	String filename;
	boolean record = false;

	ObjExport(String filename){
		beginRecord("nervoussystem.obj.OBJExport","obj_export/"+filename+".obj");
		this.filename = filename;
		this.record = true;
		println("ObjExport started ------------- " + frameCount);
	}

	void update(){
		if(this.record){
			endRecord();
			this.record = false;
			println("ObjExport finished ------------- " + frameCount);
			println("obj_export/"+this.filename+".obj");
		}
	}
}