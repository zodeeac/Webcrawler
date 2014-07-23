package UrlPopup
{
	import flash.events.Event;
	
	public class UrlEvent extends Event
	{
		public static const ENTERED:String = "ENTERED";
		
		private var _url:String;
		
		public function UrlEvent(type:String, url:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_url = url;
		}
		
		public function get url():String {
			return _url;
		}
	}
}