/*
 * class for handling multiple easing
 *
 * usage :
 * new Ease(float defaultEasing, [boolean debug]);
 *
 * void Ease.set("NameOfTheEasing", float defaultValue, [float newEasingValue]);
 * float Ease.get("NameOfTheEasing");
 * boolean Ease.set_easing("NameOfTheEasing", float newEasingValue)
 *
 * call Ease.update(); at the beginning of the draw() to update all the easings.
 */

class Ease{
	ArrayList<Value> values = new ArrayList<Value>();
	float defaultEasing;
	boolean DEBUG;

	Ease(float defaultEasing, boolean... debug){
		this.defaultEasing = defaultEasing;
		this.DEBUG = (debug.length>0 && debug[0]);
	}

	// METHODS -----------
		void update(){ for(int i=0; i<this.values.size();i++) this.values.get(i).update(); }

		void set(String name, float value, float... e){
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name){
					v.targetValue = value;
					v.easing = (e.length>0) ? e[0] : v.easing;
					if(this.DEBUG) println(name+" : value set to "+value);
					return;
				}
			}
			this._define(name, value, (e.length>0) ? e[0] : this.defaultEasing);
		}

		float get(String name){
			float rtrn = 0.0;
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name) rtrn = v.value;
			}
			return rtrn;
		}

		boolean set_easing(String name, float new_easing){
			for(int i=0; i<this.values.size();i++){
				Value v = this.values.get(i);
				if(v.name == name){
					if(this.DEBUG) println(name+" : easing set to "+new_easing+" (previous = "+v.easing+")");
					v.easing = new_easing;
					return true;
				}
			}
			if(this.DEBUG) println(name+" not defined");
			return false;
		}

	// CORE -----------
		void _define(String name, float value, float easing){
			if(this.DEBUG) println(name+" not defined :\nnew "+name+" set to "+value+" with "+easing+" easing");
			values.add( new Value(name, value, easing) );
		}

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
