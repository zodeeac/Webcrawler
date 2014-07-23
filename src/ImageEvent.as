package
{
	import flash.events.Event;
	
	public class ImageEvent extends Event
	{
		
		private var _url:String;
		
		public static const COMPLETE:String = "COMPLETE";
		
		public function ImageEvent(type:String, url:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_url = url;
		}
		
		public function get url():String {
			return _url;
		}
	}
}