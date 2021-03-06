﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class Bullet extends MovieClip {
		
		var speed:Number = 15;
		var range:Number = 0;
		var hitPoints:Number;
		var startPosition:Point = new Point(12,12);
		var currPosition:Point = new Point(0,0);
		
		public function Bullet(strtx:Number, strty:Number, hp:Number, range:Number) 
		{
			this.range = range;
			this.hitPoints = hp;
			startPosition.x = strtx;
			startPosition.y = strty;
			
		}
		
		public function updateBullet():void
		{
			this.x = this.x + Math.cos(this.rotation/180*Math.PI)*speed;
			this.y = this.y + Math.sin(this.rotation/180*Math.PI)*speed;
		}
		
		public function getStartPosition(): Point
		{
			return startPosition;
		}
		
		public function getHitPoints(): Number
		{
			return hitPoints;
		}
		
		public function getCurrentPosition(): Point
		{
			currPosition.x = x;
			currPosition.y = y;
			return currPosition;
		}
		
		public function getRange(): Number
		{
			return this.range;
		}
		
		
	}
}
