package
{
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