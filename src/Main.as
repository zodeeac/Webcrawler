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
		
		public function crawl():void
		{ 
			var urlWindow:UrlPopup.UrlPopup = UrlPopup.UrlPopup(PopUpManager.createPopUp(_wc, UrlPopup.UrlPopup, true));
			urlWindow.title = "Enter a URL";
			
			PopUpManager.centerPopUp(urlWindow); // centers popup
		}
		
		public function saveSelected():void
		{
			trace("saving selected...");
		}
		
		public function saveAll():void
		{
			trace("saving all...");
		}
	}
}