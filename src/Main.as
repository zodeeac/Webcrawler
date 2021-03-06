package
{
	import UrlPopup.UrlEvent;
	import UrlPopup.UrlPopup;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.*;
	
	import mx.collections.ArrayList;
	import mx.core.FlexGlobals;
	import mx.managers.*;
	import mx.rpc.events.*;
	import mx.rpc.http.*;


	public class Main
	{
		
		private var _wc:Webcrawler;
		private var _imageSaver:ImageSaver;
		private var _imagesOnSite:uint;
		private var _imagesLoaded:uint;
		
		public function Main(wc:Webcrawler)
		{
			_wc = wc;
			_imagesOnSite = 0;
			_imagesLoaded = 0;
			_imageSaver = new ImageSaver();
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
			_imageSaver.saveImage(_wc.controls.crawled.selectedItem);
		}
		
		public function saveAll():void
		{
			_imageSaver.saveImages(_wc.controls.crawled.dataProvider as ArrayList);
		}
		
		public function onUrlInput(e:UrlEvent):void 
		{
			// remove event!
			e.target.removeEventListener(UrlPopup.UrlEvent.ENTERED, onUrlInput);
			
			_wc.controls.crawled.clearList();
			_wc.display.imageShown.source = new BitmapData(1,1,false,0x333333333);
			
			// Disable all controls
			this.deactivateAllControls();
			
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
		
		public function onLoadComplete (e:ResultEvent):void 
		{
			// Remove events
			e.target.removeEventListener(ResultEvent.RESULT, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			
			var httpService:Object =  e.target; // HTTP Service object
			
			// Match result against image element with gifs, jpgs and pngs and receive an array with every match
			var regEx:RegExp = /src="[^?#"]*\.(gif|jpg|jpeg|png)/g;
			var imageTags:Array = e.result.match(regEx);
			_imagesOnSite = imageTags.length;
			_imagesLoaded = 0;
			
			// Go through all images and remove the prefix (src=")
			var images:ArrayList = new ArrayList();
			for (var tag:String in imageTags) 
			{
				// Remove the prefix
				var image:String = imageTags[tag].substr(5, imageTags[tag].length);
				// If url to image is not remote to the requested site, it is located on the site itself => add URL to the requested url
				if ( image.indexOf("http://") != 0 && image.indexOf("https://") != 0 && image.indexOf("//") != 0) 
				{
					trace(image + " => ");
					// If image path is relative => append a slash
					var imageUrlPrefix:String = "";
					if (image.indexOf("/") != 0) 
					{
						var trailingSlash:String = (httpService.url.substr(httpService.url.length-1, httpService.url.length) == "/") ? "" : "/";
						imageUrlPrefix = httpService.url+trailingSlash;
					// If path is absolute get the base url
					} 
					else 
					{
						// If slash after the base url is missing (=> only base url given) add the whole url, otherwise add just the base url
						var slashAfterBaseUrl:int = httpService.url.indexOf("/",9);
						if (slashAfterBaseUrl == -1) 
						{
							imageUrlPrefix = httpService.url;
						} 
						else 
						{
							imageUrlPrefix = httpService.url.substr(0, slashAfterBaseUrl);	
						}						
					}
					image = imageUrlPrefix + image; // Prepend URL prefix
					
				// if shorthand protocoll notation is used (e.g. by google)
				} 
				else if (image.indexOf("//") == 0) 
				{
					image = "http:"+image;
				}
				
				this.analyseImage(image);
			}
			
		}
		
		public function onLoadError (e:FaultEvent):void 
		{
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			e.target.removeEventListener(FaultEvent.FAULT, onLoadError);
			this.activateAllControls();
			trace(e.fault.faultString);
		}
		
		private function analyseImage (image:String):void 
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError);
			loader.load(new URLRequest(image));
		}
		
		private function onImageLoaded (e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, onImageLoaded);	
			var bitmap:Bitmap = e.target.content as Bitmap;
			
			
			_imagesLoaded++;
			if (bitmap.width == 1 || bitmap.height == 1) 
			{
				return;
			}
			
			trace( bitmap.loaderInfo.url);
			
			
			FlexGlobals.topLevelApplication.controls.crawled.addImage(bitmap);
			
			
			this.checkLoaded();
		}
		
		private function onImageError (e:IOErrorEvent):void {
			
			_imagesLoaded++;
			
			this.checkLoaded();
		}
		
		private function checkLoaded ():void {
			trace(_imagesLoaded + " == " + _imagesOnSite + " ?");
			if (_imagesLoaded == _imagesOnSite) {
				this.activateAllControls();
			}
		}
		
		private function activateAllControls ():void {
			FlexGlobals.topLevelApplication.controls.crawl.enabled = true;
			FlexGlobals.topLevelApplication.controls.crawled.enabled = true;
			if (FlexGlobals.topLevelApplication.controls.crawled.dataProvider.length > 0) {
				FlexGlobals.topLevelApplication.controls.saveAll.enabled = true;	
			}
		}
		
		private function deactivateAllControls ():void {
			FlexGlobals.topLevelApplication.controls.crawl.enabled = false;
			FlexGlobals.topLevelApplication.controls.crawled.enabled = false;
			FlexGlobals.topLevelApplication.controls.saveSel.enabled = false;
			FlexGlobals.topLevelApplication.controls.saveAll.enabled = false;
		}
		
	}
}