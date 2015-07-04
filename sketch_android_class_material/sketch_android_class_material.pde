Material material;

void setup(){
	size(800, 800);
	material = new Material(this);
	rectMode(CENTER);
	noStroke();
}

void draw(){
	background(material.COLOR(BLUE));

	fill(material.COLOR(RED, 100));
	rect(width*.5, height*.5 - 50, 200, 50);

	fill(material.COLOR(RED, 200));
	rect(width*.5, height*.5, 200, 50);

	fill(material.COLOR(RED, 400));
	rect(width*.5, height*.5 + 50, 200, 50);

	fill(material.COLOR(RED, 700));
	rect(width*.5, height*.5 + 100, 200, 50);
}