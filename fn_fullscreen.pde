/* USAGE :
 * call FULLSCREEN(monitor, [renderer])
 * instead of
 * size(width, height, [renderer]);
 */

import java.awt.Rectangle;
import java.awt.*;
import java.awt.image.BufferedImage;

Rectangle monitor = new Rectangle();

public void fullscreen(int monitor, String... renderer){
	GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	GraphicsDevice[] gs = ge.getScreenDevices();
	GraphicsDevice gd = gs[monitor];
	GraphicsConfiguration[] gc = gd.getConfigurations();
	monitor = gc[0].getBounds();

	if(renderer.length>0) size(monitor.width, monitor.height, renderer[0]);
	else size(monitor.width, monitor.height);
	frame.setLocation(monitor.x, monitor.y);
	// frame.setAlwaysOnTop(true);
}

public void init(){
	frame.removeNotify();
	frame.setUndecorated(true);
	super.init();
}