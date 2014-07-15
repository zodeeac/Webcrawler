package
{
	import UrlPopup.UrlEvent;
	import UrlPopup.UrlPopup;
	
	import flash.events.*;
	import flash.net.*;
	
	import mx.managers.*;
	import mx.rpc.events.*;
	import mx.rpc.http.*;


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
			
			urlWindow.addEventListener(UrlPopup.UrlEvent.ENTERED, onUrlInput);
			
			PopUpManager.centerPopUp(urlWindow); // centers popup
		}
		
		public function saveSelected()
		{
			trace("saving selected...");
		}
		
		public function saveAll()
		{
			trace("saving all...");
		}
		
		public function onUrlInput(e:UrlEvent):void {
			// remove event!
			//e.target.removeEventListener(UrlPopup.UrlEvent.ENTERED, onUrlInput);
			
			/*
			var request = new URLRequest(e.url); 
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onLoadComplete); 
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onLoadStatus);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			
			loader.load(request);
			*/
			
			var httpService:HTTPService = new HTTPService();
			httpService.url = e.url;
			httpService.resultFormat = "text";
			httpService.method = "GET";
			httpService.addEventListener(ResultEvent.RESULT, onLoadComplete);
			httpService.addEventListener(FaultEvent.FAULT, onLoadError);
			httpService.send();
		}
		
		public function onLoadComplete (e:ResultEvent):void {
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			//trace(e.result);
			
			var httpService:Object =  e.target; 
			
			var regEx:RegExp = /src="[^?#"]*\.(gif|jpg|jpeg|png)/g;
			var imageTags:Array = e.result.match(regEx);
			
			var images:Array = new Array();
			for (var tag:String in imageTags) {
				var image:String = imageTags[tag].substr(5, imageTags[tag].length);
				// if url to image is not remote to the requested site, it is located on the site itself => add URL to the requested url
				if ( image.indexOf("http://") != 0 && image.indexOf("https://") != 0) {
					// if image path is relative => prepend a slash
					var imageUrlPrefix:String = "";
					if (image.indexOf("/") != 0) {
						imageUrlPrefix = httpService.url+"/";
					} else {
						imageUrlPrefix = httpService.url.substr(0, httpService.url.indexOf("/",9));
					}
					image = httpService.url + image;
				}
				images.push(image);
			}
			
			trace(images);
		}
		
		public function onLoadError (e:FaultEvent):void {
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			trace(e.fault.faultString);
		}
		
	}
}