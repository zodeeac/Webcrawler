package
{
	import UrlPopup.UrlPopup;
	
	import mx.managers.*;


	public class Main
	{
		
		private var _wc:Webcrawler;
		
		public function Main(wc:Webcrawler)
		{
			_wc = wc;
		}
		
		public function crawl()
		{
			trace("crawling...");
		
			var urlWindow:UrlPopup.UrlPopup = UrlPopup.UrlPopup(PopUpManager.createPopUp(this, UrlPopup.UrlPopup , true));
			
			urlWindow.x = _wc.width/2 - urlWindow.width/2;
			urlWindow.y = _wc.height/2 - urlWindow.height/2;
			
		}
		
		public function saveSelected()
		{
			trace("saving selected...");
		}
		
		public function saveAll()
		{
			trace("saving all...");
		}
	}
}