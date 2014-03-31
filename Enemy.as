package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class Enemy extends MovieClip
	{

		var speed:Number = 5;
		var waypoints:Array;
		var currWP:Number = 0;
		var distWP:Number = 0;
		var offSet:int = 100;
		var hb:HealthBar = new HealthBar();
		var fullHealth:Number;
		var moneyValue:Number;
		var lifePoints:Number;

		public function Enemy(wp:Array, moneyValue:Number, lifePoints:Number)
		{
			this.lifePoints = lifePoints;
		    fullHealth = lifePoints;
			this.moneyValue = moneyValue;
			waypoints = wp;
			hb.x = -25;
			hb.y = -40;
			addChild(hb);
		}
		public function updateEnemy():void
		{
			distWP = getDistanceToWayPoint();
			if (distWP < 5)
			{
				currWP++;
			}
			moveEnemy1();
		}

		public function getDistanceToWayPoint():Number
		{
			var dist:Number = -1;
			if (waypoints[currWP] != null)
			{
				var dx:Number = waypoints[currWP].x - x;
				var dy:Number = waypoints[currWP].y - y;
				dist = Math.sqrt(dx*dx + dy*dy);
			}

			return dist;
		}

		public function moveEnemy1():void
		{
			if (waypoints[currWP] != null)
			{
				var dx:Number = waypoints[currWP].x - x;
				var dy:Number = waypoints[currWP].y - y;
				rotation = Math.atan2(dy,dx) / Math.PI * 180;
				this.x = this.x + Math.cos(this.rotation / 180 * Math.PI) * speed;
				this.y = this.y + Math.sin(this.rotation / 180 * Math.PI) * speed;
			}
			rotation = 0;  // Keep enemy oriented in single position
		}
		
		public function setLifePoints(lp:Number):void
		{
			this.lifePoints = lp;
		}
		
		public function getLifePoints():Number
		{
			return lifePoints;
		}
		
		public function changeLifePoints(cp:Number):void
		{
		    this.lifePoints += cp;
			hb.greenBar.width *= (this.lifePoints/fullHealth);
		}
		
		public function setBankPoints(mv:Number):void
		{
			this.moneyValue = mv;
		}
		
		public function getBankPoints():Number
		{
			return moneyValue;
		}
		


	}
}