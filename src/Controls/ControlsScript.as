// ActionScript file

import Image.ImageElement;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;

import mx.collections.ArrayList;
import mx.core.BitmapAsset;
import mx.core.FlexGlobals;
import mx.core.IVisualElement;

public function set dataProvider (data:ArrayList):void
{
	var dp:ArrayList = new ArrayList();
	for each(var element:Bitmap in data)
	{
		var imgElem:ImageElement = new ImageElement();
		imgElem.image = element;
		imgElem.toolTip = element.loaderInfo.url;
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

public function onChange():void
{
	FlexGlobals.topLevelApplication.display.setImage(dataProvider.getItemAt(crawled.selectedIndex).image);
	FlexGlobals.topLevelApplication.controls.saveSel.enabled = true;
}
	