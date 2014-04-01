package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;


	public class LevelOne extends MovieClip
	{
		var pa:PlayArea;
		var ma:MenuArea;
		var ia:InfoArea;
		var maxEnemies:Number = 0;
		var waypoints:Array;
		public var enemies:Array;
		var bullets:Array;
		var bullet:Bullet;
		var gameBank:PointBank = new PointBank(600);
		var lifePoints:PointBank = new PointBank(100);
		var waypointObject:DisplayObject;
		var enemyDelay:int = 24;
		var enemy:Enemy;
		var enemyTimer:Timer = new Timer(2000,15);
		var sendEnemy:Boolean = false;
		var turret:Turret;
		var range:Range = new Range(30);


		public function LevelOne()
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
			updateInfoArea();
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
			ia.bankValue.text = String(gameBank.getValue());
			ia.lifePoints.text = String(lifePoints.getValue());
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
		//  ********************************************************************
		private function getDistance(o1:Object, o2:Object):Number
		{
			var dx:Number = o2.x - o1.x;
			var dy:Number = o2.y - o1.y;
			return Math.sqrt(dx*dx + dy*dy);
		}
		//  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		private function bulletLoop(evt:Event):void
		{
			for (var oi:int = 0; oi < bullets.length; oi++)
			{
				if (bullets[oi] != null)
				{
					bullets[oi].updateBullet();
					if (getDistance(bullets[oi].getStartPosition(),bullets[oi].getCurrentPosition()) > bullets[oi].getRange())
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
							enemies[j].changeLifePoints(-bullets[i].getHitPoints());
							// remove ornament from parent;
							this.removeChild(bullets[i]);
							// remove ornament from the array
							bullets.splice(i,1);
						}
						if (enemies[j].getLifePoints() < 0)
						{
							gameBank.changeValue(enemies[j].getMoneyValue());
							// remove devil from parent
							this.removeChild(enemies[j]);
							// remove devil from the array
							enemies.splice(j,1);
						}

					}

				}
			}

		}// end loop function

		public function makeBullet(tx:int, ty:int, tr:int, bt:int, r:Number):void
		{

			//var bullet:Bullet = new Bullet(100);
			switch (bt)
			{

				case 1 :
					bullet = new BulletOne(tx,ty,10,r);
					break;

				case 2 :
					bullet = new BulletTwo(tx,ty,20,r);
					break;

				case 3 :
					bullet = new BulletThree(tx,ty,30,r);
					break;
				case 4 :
					bullet = new BulletFour(tx,ty,40,r);
					break;

			}
			bullet.x = tx;
			bullet.y = ty;
			bullet.rotation = tr;
			bullet.mask = createPlayAreaMask();
			bullets.push(bullet);
			this.addChild(bullet);
		}

		private function initEnemy():void
		{

			if (sendEnemy == true)
			{

				var enemyNumber:Number = Math.floor(Math.random() * 4) + 1;
				switch (enemyNumber)
				{

					case 1 :
						enemy = new EnemyOne(waypoints,100,200);//bankpoints and lifepoints
						break;

					case 2 :
						enemy = new EnemyTwo(waypoints,150,200);
						break;

					case 3 :
						enemy = new EnemyThree(waypoints,200,200);
						break;
					case 4 :
						enemy = new EnemyFour(waypoints,250,200);
						break;

				}
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
			50,
			1));

			ma.addTile(new Tile(new IconTwo(),
			50,
			2));

			ma.addTile(new Tile(new IconThree(),
			50,
			3));

			ma.addTile(new Tile(new IconFour(),
			50,
			4));

		}


	}

}