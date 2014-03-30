package  {
	
	public class PointBank {

       private var pointValue:Number;

		public function PointBank(sv:Number) {
			this.pointValue = sv;
		}
		
		public function setValue(v:Number):void
		{
			pointValue = v;
		}
		public function getValue():Number
		{
			return pointValue;
		}
		public function changeValue(c:Number):void
		{
			pointValue += c;
		}

	}
	
}
