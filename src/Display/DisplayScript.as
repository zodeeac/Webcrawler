import flash.display.Bitmap;
import flash.display.BitmapData;

import mx.core.FlexGlobals;

public function init():void
{
	var data:BitmapData = new BitmapData(1,1,false,0x333333333);
	this.imageShown.source = data;
}

public function setImage(image:Bitmap):void
{
	this.imageShown.source = image;
}