package 
{

	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.media.Sound;

	public class Christmas extends MovieClip
	{
		var reqSound:URLRequest = new URLRequest("jb.mp3");
		var jb:Sound = new Sound(reqSound);


		public function Christmas()
		{
			stop();
			jb.play();
		}
	}
}