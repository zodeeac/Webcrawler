import com.adobe.images.JPGEncoder;

import flash.display.BitmapData;
import flash.events.*;
import flash.filesystem.File;
import flash.geom.Rectangle;
import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.utils.*;

import mx.collections.ArrayList;

public function saveImage (image:Object):void {
	var fr:FileReference = new FileReference();
	
	var encoder:JPGEncoder = new JPGEncoder(90);
	var jpgImage:ByteArray = encoder.encode(image['image']);
	fr.save(jpgImage);
	
	var url:String = (image['url'] as String);
	var fileName:String = url.substr(url.lastIndexOf("/")+1, url.lastIndexOf(".")-1);
	var file:File = new File();
	file.save(jpgImage, fileName);
	
}

public function saveImages (images:ArrayList):void {
	/*
	var fr:FileReference = new FileReference();
	
	var bounds:Rectangle = image.bitmapData.rect;
	var jpgImage:ByteArray = image.bitmapData.encode(bounds, new JPEGEncoderOptions(50));
	fr.save(jpgImage);
	fr.
	*/
}

private function onFileSelect (e:Event):void {
	
}