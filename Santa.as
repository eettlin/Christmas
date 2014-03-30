package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Sprite;

	public class Santa extends MovieClip
	{
		private var range:Number;
		private var bulletHP:Number;
		private var cost:Number;

		var fireDelay:int = 0;
		var dtd:Number;
		var shortestDistance:Number;
		var currDevil:int;
		var d:Array;

		public function Santa(r:Number, b:Number, c:Number)
		{
			this.range = r;
			this.bulletHP = b;
			this.cost = c;
			addEventListener(Event.ENTER_FRAME, updateSanta);
		}

		public function updateSanta(evt:Event):void
		{
			d = (root as Christmas).devils
			;
			shortestDistance = 1000;
			for (var i:int = 0; i < d.length; i++)
			{
				dtd = getDistanceToDevil(d[i]);
				if (dtd < shortestDistance)
				{
					shortestDistance = dtd;
					currDevil = i;
				}
			}

			var dx:Number = x - d[currDevil].x;
			var dy:Number = y - d[currDevil].y;
			rotation = 180 + Math.atan2(dy,dx) / Math.PI * 180;
			//parent.addEventListener(MouseEvent.CLICK, fireSanta);
			fireDelay--;

			if ((parent) != null && fireDelay < 0  && getDistanceToDevil(d[currDevil]) <= this.range )
			{
				(parent as MovieClip).makeOrnament(x, y, rotation);
				//play();
				fireDelay = 24;
			}
		}

		public function getDistanceToDevil(devil:Devil):Number
		{
			var dx:Number = x - devil.x;
			var dy:Number = y - devil.y;

			return Math.sqrt(dx*dx + dy*dy);
		}
		
		public function getRange():Number
		{
			return range;
		}
		public function getCost():Number
		{
			return cost;
		}



	}
}