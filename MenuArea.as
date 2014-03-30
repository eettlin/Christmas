package  {
	
	import flash.display.MovieClip;
	
	
	public class MenuArea extends MovieClip {
		
		public var tiles:Array;
		
		
		public function MenuArea() {
			 tiles = new Array();
		}
		
		
		public function menuAreaFunction():void
		{
			trace("I'm inside maf yo");
		}
		
		public function addTile(t:Tile):void
		{
			t.x = 5;
			t.y = tiles.length*105 +20;
			tiles.push(t);
			addChild(t);
		}
		
	}
	
}
