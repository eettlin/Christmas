package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	
	public class Ornament extends MovieClip {
		
		
		var speed:Number = 8;
		var startPosition:Point = new Point();
		
		
		
		public function Ornament() {
			
		}
		
		public function updateOrnament():void
		{
			x = x + Math.cos(rotation/180*Math.PI)*speed;
			y = y + Math.sin(rotation/180*Math.PI)*speed;
		}
		
		/*public function setStartPosition():Point
		{
			startPosition = sp;			
		}*/
		
	}
}
