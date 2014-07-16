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
		private var _imageList:Array;
		
		public function Main(wc:Webcrawler)
		{
			_wc = wc;
			_imageList = new Array();
		}
		
		public function get images():Array {
			return _imageList;
		}
		
		public function crawl():void
		{ 
			var urlWindow:UrlPopup.UrlPopup = UrlPopup.UrlPopup(PopUpManager.createPopUp(_wc, UrlPopup.UrlPopup, true));
			urlWindow.title = "Enter a URL";
			
			urlWindow.addEventListener(UrlPopup.UrlEvent.ENTERED, onUrlInput);
			
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
		
		public function onUrlInput(e:UrlEvent):void {
			// remove event!
			e.target.removeEventListener(UrlPopup.UrlEvent.ENTERED, onUrlInput);
			
			// Create HTTP Service with properties
			var httpService:HTTPService = new HTTPService();
			httpService.url = e.url;
			httpService.resultFormat = "text";
			httpService.method = "GET";
			
			// Events to listen to, when complete or an error accured
			httpService.addEventListener(ResultEvent.RESULT, onLoadComplete);
			httpService.addEventListener(FaultEvent.FAULT, onLoadError);
			
			// Send everything
			httpService.send();
		}
		
		public function onLoadComplete (e:ResultEvent):void {
			// Remove events
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			
			var httpService:Object =  e.target; // HTTP Service object
			
			// Match result against image element with gifs, jpgs and pngs and receive an array with every match
			var regEx:RegExp = /src="[^?#"]*\.(gif|jpg|jpeg|png)/g;
			var imageTags:Array = e.result.match(regEx);
			
			// Go through all images and remove the prefix (src=")
			var images:Array = new Array();
			for (var tag:String in imageTags) {
				var image:String = imageTags[tag].substr(5, imageTags[tag].length); // Remove the prefix
				// If url to image is not remote to the requested site, it is located on the site itself => add URL to the requested url
				if ( image.indexOf("http://") != 0 && image.indexOf("https://") != 0) {
					// If image path is relative => append a slash
					var imageUrlPrefix:String = "";
					if (image.indexOf("/") != 0) {
						imageUrlPrefix = httpService.url+"/";
					// If path is absolute get the base url
					} else {
						imageUrlPrefix = httpService.url.substr(0, httpService.url.indexOf("/",9));
					}
					image = imageUrlPrefix + image; // Prepend URL prefix
				}
				images.push(image); // Push to output array
			}
			
			// Set imageList to newly generated Array
			_imageList = images;
		}
		
		public function onLoadError (e:FaultEvent):void {
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			trace(e.fault.faultString);
		}
		
	}
}