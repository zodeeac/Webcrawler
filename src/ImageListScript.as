// ActionScript file

import flash.display.Bitmap;
import flash.display.BitmapData;

import mx.collections.ArrayList;
import mx.core.Application;
import mx.core.BitmapAsset;
import mx.core.FlexGlobals;
import mx.core.IVisualElement;

public function set dataProvider (data:ArrayList):void
{
	var dp:ArrayList = new ArrayList();
	for each(var element:String in data)
	{
		var imgElem:ImageElement = new ImageElement();
		imgElem.image = element;
		imgElem.picture.toolTip = element;
		dp.addItem(imgElem);
	}
	this.crawled.dataProvider = dp;
}

public function get dataProvider():ArrayList
{
	return this.crawled.dataProvider as ArrayList;
}

public function remove(element:IVisualElement):void
{		
	(this.crawled.dataProvider as ArrayList).removeItem(element);
}
	