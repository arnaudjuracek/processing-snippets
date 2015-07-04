/*
 * material.COLOR(PRIMARY [, 100 | 200 | 400 | 700]);
 *
 */

public static final color
	RED 		= 0,
	PINK 		= 1,
	PURPLE 		= 2,
	DEEP_PURPLE = 3,
	INDIGO 		= 4,
	BLUE 		= 5,
	LIGHT_BLUE 	= 6,
	CYAN 		= 7,
	TEAL 		= 8,
	GREEN 		= 9,
	LIGHT_GREEN = 10,
	LIME 		= 11,
	YELLOW 		= 12,
	AMBER 		= 13,
	ORANGE 		= 14,
	DEEP_ORANGE = 15,
	BROWN 		= 16,
	GREY 		= 17,
	BLUE_GREY 	= 18,
	BLACK 		= 19,
	WHITE 		= 20;

public class Material{
	PApplet PARENT;

	private final color[][] PALETTE = {
		{#F44336, #FF8A80, #FF5252, #FF1744, #D50000}, 	//RED
		{#E91E63, #FF80AB, #FF4081, #F50057, #C51162}, 	//PINK
		{#9C27B0, #EA80FC, #E040FB, #D500F9, #AA00FF}, 	//PURPLE
		{#673AB7, #B388FF, #7C4DFF, #651FFF, #6200EA}, 	//DEEP_PURPLE
		{#3F51B5, #8C9EFF, #536DFE, #3D5AFE, #304FFE}, 	//INDIGO
		{#2196F3, #82B1FF, #448AFF, #2979FF, #2962FF}, 	//BLUE
		{#03A9F4, #80D8FF, #40C4FF, #00B0FF, #0091EA}, 	//LIGHT_BLUE
		{#00BCD4, #84FFFF, #18FFFF, #00E5FF, #00B8D4}, 	//CYAN
		{#009688, #A7FFEB, #64FFDA, #1DE9B6, #00BFA5}, 	//TEAL
		{#4CAF50, #B9F6CA, #69F0AE, #00E676, #00C853}, 	//GREEN
		{#8BC34A, #CCFF90, #B2FF59, #76FF03, #64DD17}, 	//LIGHT_GREEN
		{#CDDC39, #F4FF81, #EEFF41, #C6FF00, #AEEA00}, 	//LIME
		{#FFEB3B, #FFFF8D, #FFFF00, #FFEA00, #FFD600}, 	//YELLOW
		{#FFC107, #FFE57F, #FFD740, #FFC400, #FFAB00}, 	//AMBER
		{#FF9800, #FFD180, #FFAB40, #FF9100, #FF6D00}, 	//ORANGE
		{#FF5722, #FF9E80, #FF6E40, #FF3D00, #DD2C00}, 	//DEEP_ORANGE
		{#795548}, 										//BROWN
		{#9E9E9E}, 										//GREY
		{#607D8B}, 										//BLUE_GREY
		{#000000}, 										//BLACK
		{#FFFFFF} 										//WHITE
	};


	Material(PApplet parent){
		this.PARENT = parent;
	}

	// @see https://www.google.com/design/spec/style/color.html#color-ui-color-application
	// primary : public static final color
	// accent : either 100, 200, 400, 700
	public color COLOR(int primary, int... _accent){
		if(_accent.length>0){
			int accent;
			switch(_accent[0]){
				case 100 : accent = 1; break;
				case 200 : accent = 2; break;
				case 400 : accent = 3; break;
				case 700 : accent = 4; break;
				default  : accent = 0; break;
			}
			return (accent<this.PALETTE[primary].length) ? this.PALETTE[primary][accent] : #FFFFFF;
		}else return this.PALETTE[primary][0];
	}
}