package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;


	public class Christmas extends MovieClip
	{

		var pa:PlayArea;
		var ma:MenuArea;
		var ia:InfoArea;
		var maxEnemies:Number = 0;
	    var waypoints:Array;
		public var enemies:Array;
		var bullets:Array;

		var gameBank:PointBank = new PointBank(500);
		var lifePoints:PointBank = new PointBank(100);
		var waypointObject:DisplayObject;
		var enemyDelay:int = 24;
		var enemy:Enemy;
		var enemyTimer:Timer = new Timer(2000,15);
		var sendEnemy:Boolean = false;
		var turret:Turret;
		var range:Range = new Range(30);

		public function Christmas()
		{
			
			waypoints = new Array();
			enemies = new Array();
			bullets = new Array();
			setAreas();
			loadWaypoints();
			enemyTimer.start();
			enemyTimer.addEventListener(TimerEvent.TIMER, enemyTimerTick);

			addEventListener(Event.ENTER_FRAME, updateChristmas);
			addEventListener(Event.ENTER_FRAME, enemyLoop);
			addEventListener(Event.ENTER_FRAME, bulletLoop);
			
			
		}
		public function updateChristmas(evt:Event):void
		{

			initEnemy();
			//updateInfoArea();
		}
		
				public function addTurret(t:Turret):void
		{
			
			range.updateRangeRadius(t.getRange());
			this.addChild(range);
			turret = t;
			turret.x = mouseX;
			turret.y = mouseY;
			turret.startDrag();
			turret.mask = createPlayAreaMask();
			addChild(turret);
			range.visible = true;
			addEventListener(MouseEvent.MOUSE_UP, releaseTurret);
			addEventListener(Event.ENTER_FRAME, setRange );
		}

		private function updateInfoArea():void
		{
			ia.bank_value.text = String(gameBank.getValue());
			ia.life_points.text = String(lifePoints.getValue());
		}
		public function enemyTimerTick(tevt:TimerEvent):void
		{
			sendEnemy = true;
		}
		private function enemyLoop(evt:Event):void
		{
			for (var di:int = 0; di < enemies.length; di++)
			{
				if (enemies[di] != null)
				{
					enemies[di].updateEnemy();
				}
			}

		}


		private function bulletLoop(evt:Event):void
		{
			for (var oi:int = 0; oi < bullets.length; oi++)
			{
				if (bullets[oi] != null)
				{
					bullets[oi].updateBullet();

					if (bullets[oi].x < 0||
					   bullets[oi].x > 800||
					   bullets[oi].y < 0||
					   bullets[oi].y > 800)
					{
						// remove ornament from parent
						this.removeChild(bullets[oi]);
						// remove ornament from the array
						bullets.splice(oi,1);
					}
				}
			}

			for (var i:int = bullets.length -1; i >= 0; i--)
			{
				for (var j:int = enemies.length -1; j >= 0; j--)
				{

					if (bullets[i] != null && enemies[j] != null)
					{
						if (bullets[i].hitTestObject(enemies[j]))
						{
							// remove ornament from parent
							this.removeChild(bullets[i]);
							// remove ornament from the array
							bullets.splice(i,1);
							// remove devil from parent
							this.removeChild(enemies[j]);
							// remove devil from the array
							enemies.splice(j,1);
						}
					}

				}
			}

		}// end loop function

		public function makeBullet(sx:int, sy:int, sr:int, bt:int, r:Number):void
		{

			var bullet:Bullet = new Bullet(100);
			bullet.x = sx;
			bullet.y = sy;
			bullet.rotation = sr;
			bullet.mask = createPlayAreaMask();
			bullets.push(bullet);
			this.addChild(bullet);
		}

		private function initEnemy():void
		{
			
			if (sendEnemy == true)
			{
				var enemy:Enemy = new Enemy(waypoints);
				enemy.x = 850;
				enemy.y = 150;
				enemy.rotation = Math.random() * 360;
				enemy.mask = createPlayAreaMask();
				enemies.push(enemy);
				this.addChild(enemy);
				maxEnemies++;
				enemyDelay = 24;
				sendEnemy = false;
			}
		}


		public function releaseTurret(me:MouseEvent):void
		{
			turret.stopDrag();
			range.visible = false;
		}

		public function setRange(e:Event):void
		{
			range.x = turret.x;
			range.y = turret.y;
		}
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		public function createPlayAreaMask():Sprite
		{
			var playAreaMask:Sprite = new Sprite();
			playAreaMask.graphics.beginFill(0xFFFFFF);
			playAreaMask.graphics.drawRect(pa.x, pa.y, pa.width, pa.height);
			playAreaMask.graphics.endFill();

			return playAreaMask;

		}

		public function setAreas():void
		{
			pa = new PlayArea();
			pa.x = 100;
			pa.y = 0;
			addChild(pa);

			ia = new InfoArea();
			ia.x = 0;
			ia.y = 600;
			addChild(ia);

			ma = new MenuArea();
			ma.x = 0;
			ma.y = 0;
			addChild(ma);
			setMenuArea();

		}

		public function loadWaypoints():void
		{
			var i:int = 1;
			waypointObject = pa.getChildByName("WP" + i);

			while ( waypointObject != null)
			{
				waypoints.push(waypointObject);
				i++;
				waypointObject = pa.getChildByName("WP" + i);
			}
		}


		public function setMenuArea():void
		{

			ma.addTile(new Tile(new IconOne(),
			100,
			1));

			ma.addTile(new Tile(new IconTwo(),
			100,
			2));

			ma.addTile(new Tile(new IconThree(),
			100,
			3));

			ma.addTile(new Tile(new IconFour(),
			100,
			4));

		}


	}

}