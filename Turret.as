package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;


	public class Turret extends MovieClip
	{
		public var ts:TurretSettings = new TurretSettings();
		
		var fireDelay:int = 0;
		var dte:Number;
		var shortestDistance:Number;
		var currEnemy:int;
		var e:Array;
		var count:Number = 0;
		var bulletType:Number;

		public function Turret()
		{
			
			addEventListener(Event.ENTER_FRAME, updateTurret);
		}

		public function updateTurret(evt:Event):void
		{
			//trace("parent = " + parent);
			/*var r:LevelOne = root as LevelOne;
			if (r == null) {
				return;
			}*/
			e = (parent as MovieClip).enemies;
			
			shortestDistance = 1000;
			for(var i:int = 0; i < e.length; i++)
			{
				dte = getDistanceToEnemy(e[i]);
				if(dte < shortestDistance)
				 {
					 shortestDistance = dte;
					 currEnemy = i;
				 }
			}
			if(e.length <= 0)
			{
				return;
			}
			var dx:Number = x - e[currEnemy].x;
			var dy:Number = y - e[currEnemy].y;
			rotation = Math.atan2(dy, dx)/Math.PI*180 + 180;
			fireDelay--;  
			if ((parent) != null && fireDelay < 0 && (getDistanceToEnemy(e[currEnemy])) <= ts.range) //added third condition
			{
				 this.bulletType = ts.bulletType;
				(parent as MovieClip).makeBullet(x, y, rotation, ts.bulletType, ts.range);
				fireDelay = 24;
			}
			
		}

		public function getDistanceToEnemy(enemy:Enemy):Number
		{
			var dx:Number = x - enemy.x;
			var dy:Number = y - enemy.y;
			return Math.sqrt(dx*dx + dy*dy);
		}

		public function createPlayAreaMask():Sprite
		{
			var playAreaMask:Sprite = new Sprite();
			playAreaMask.graphics.beginFill(0xFFFFFF);
			playAreaMask.graphics.drawRect(100, 0, 900, 600);
			playAreaMask.graphics.endFill();
			return playAreaMask;
		}
		
		public function getRange():Number
		{
			return 300;
		}

	}
}