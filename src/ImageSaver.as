package
{
	
	import com.adobe.images.JPGEncoder;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.*;
	
	import mx.collections.ArrayList;
	
	public class ImageSaver
	{
		
		private var _images:ArrayList;
		
		public function ImageSaver()
		{
			_images = new ArrayList();
		}
		
		
		
		
		public function saveImage (image:Object, safeFile:Boolean = true):Object 
		{
			var encoder:JPGEncoder = new JPGEncoder(90);
			var jpgImage:ByteArray = encoder.encode(image['image'].bitmapData); 
			
			var url:String = (image['url'] as String);
			trace(url.lastIndexOf(".") + " ---- " + url.length);
			
			var fileName:String = url.substr(url.lastIndexOf("/")+1, url.length);
			fileName = fileName.substr(0,fileName.lastIndexOf("."))+".jpg";
			trace(fileName);
			if (safeFile) {
				var file:File = new File();
				file.save(jpgImage, fileName);
			}
			return {"jpgImage": jpgImage, "fileName": fileName};
		}
		
		public function saveImages (images:ArrayList):void 
		{
			_images = images;
			var file:File = new File();
			file.addEventListener(Event.SELECT, onFileSelect);
			file.browseForDirectory("Folder to save images to");
		}
		
		private function onFileSelect (e:Event):void 
		{
			File(e.currentTarget).removeEventListener(Event.SELECT, onFileSelect);
			
			var file:File = (e.target as File);
			for (var i = 0; i < _images.length; i++) {
				var convertedImage:Object = saveImage(_images.getItemAt(i), false);
				
				var fl:File= new File( e.currentTarget.nativePath+"/"+convertedImage['fileName']);
				var fs:FileStream = new FileStream();
				fs.open(fl, FileMode.WRITE);
				fs.writeBytes(convertedImage['jpgImage'],0,convertedImage['jpgImage'].length-1);
				fs.close();
				
			}
		}
		
	}
}