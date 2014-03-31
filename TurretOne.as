package  {
	
	import flash.display.MovieClip;
	
	
	public class TurretOne extends Turret {
		
		
		public function TurretOne() {
			super();
			
			ts.bulletType = 1;
			ts.range = 100;
			ts.bankValue = 50;
		}
	}
	
}
