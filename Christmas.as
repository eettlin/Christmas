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
			if (MovieClip(this.root).currentFrame == 1)
			{
				//MovieClip(this.root).js.stop();
				//trace("MovieClip(Object(root).stage).js.stop(); = " + MovieClip(Object(root).stage).js.stop() );
				//NRPSText_mc.gotoAndPlay("NRPSFadeIn");
				//MovieClip(Object(root).stage).js.stop();
			}
		}
	}
}