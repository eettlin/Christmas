package 
{

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.*;


	public class Tile extends MovieClip
	{

		private var cost:int;
		public var range:int;
		private var turretNumber:Number = 1;
		var t:Turret;
		var wp:Array;

		public function Tile(image:DisplayObject, cost:int, tn:int)
		{
			turretNumber = tn;
			this.cost = cost;
			image.x = 50;
			image.y = 40;
			addChild(image);
			addEventListener(MouseEvent.MOUSE_DOWN, spawnTurret);
		}

		public function spawnTurret(e:MouseEvent):void
		{
			
			/*trace("parent = " + parent);
			trace("parent.parent = " + parent.parent);
			trace("parent.parent.parent = " + parent.parent.parent);*/
			switch (turretNumber){

					case 1:
						t = new TurretOne();
						break;

					case 2:
						t = new TurretTwo();
						break;

					case 3:
						t = new TurretThree();
						break;
					case 4:
						t = new TurretFour();
						break;

				}

			if (t != null )
			{
				//trace("t = " + t);
				t.x = 100;
				t.y = 100;
				
				(parent.parent as MovieClip).addTurret(t);
			}
			else if (t!= null)
			{
				trace("Insufficient Funds");
			}
		}
	}

}