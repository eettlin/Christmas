package  {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Range extends Sprite {
		
		private var rangeRadius:Number;
		var center:Point;
		
		public function Range(r:int) {
			this.rangeRadius = r;
			this.width = 2*r;
			this.height = 2*r;
			this.alpha = .35;
		}
		
		public function updateRangeRadius(r:Number):void
		{
			this.rangeRadius = r;
			this.width = 2*rangeRadius;
			this.height = 2*rangeRadius;
		}
	}
	
}
