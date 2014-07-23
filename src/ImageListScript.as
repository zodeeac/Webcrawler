// ActionScript file

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;

import mx.collections.ArrayList;
import mx.controls.List;
import mx.core.Application;
import mx.core.BitmapAsset;
import mx.core.FlexGlobals;
import mx.core.IVisualElement;

import spark.primitives.supportClasses.FilledElement;

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
	FlexGlobals.topLevelApplication.display.imageShown.source = dataProvider.getItemAt(crawled.selectedIndex).image; 
}
	