import com.adobe.images.JPGEncoder;

import flash.display.BitmapData;
import flash.events.*;
import flash.filesystem.File;
import flash.geom.Rectangle;
import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.utils.*;

import mx.collections.ArrayList;

public function saveImage (image:Object):void 
{
	var encoder:JPGEncoder = new JPGEncoder(90);
	var jpgImage:ByteArray = encoder.encode(image['image'].bitmapData); 

	trace(image['url']);
	var url:String = (image['url'] as String);
	trace(url.lastIndexOf(".") + " ---- " + url.length);
	
	var fileName:String = url.substr(url.lastIndexOf("/")+1, url.length);
	fileName = fileName.substr(0,fileName.lastIndexOf("."))+".jpg";
	trace(fileName);
	var file:File = new File();
	file.save(jpgImage, fileName);
	
}

public function saveImages (images:ArrayList):void 
{
	
}

private function onFileSelect (e:Event):void 
{
	
}