// ActionScript file

import mx.core.Application;
import mx.core.FlexGlobals;

private var _dataProvider:Array;

public function set dataProvider (data:Array):void
{
	_dataProvider = data;
	this.crawled.removeAllElements();
	for each(var element:String in _dataProvider)
	{
		var imgElem:ImageElement = new ImageElement();
		imgElem.image = element;
		this.crawled.addElement(imgElem);
	}
}

public function get dataProvider():Array
{
	return _dataProvider;
}
	