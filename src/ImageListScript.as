// ActionScript file

import mx.core.Application;
import mx.core.FlexGlobals;
import mx.core.IVisualElement;

private var _dataProvider:Array;

public function set dataProvider (data:Array):void
{
	_dataProvider = data;
	this.crawled.removeAllElements();
	for each(var element:String in _dataProvider)
	{
		var imgElem:ImageElement = new ImageElement();
		imgElem.list = this;
		imgElem.image = element;
		imgElem.picture.toolTip = element;
		this.crawled.addElement(imgElem);
	}
}

public function get dataProvider():Array
{
	return _dataProvider;
}

public function remove(element:IVisualElement):void
{		
	var elemIndex:int = crawled.getElementIndex(element);
	crawled.removeElement(element);
	trace("Element "+_dataProvider[elemIndex]);
	_dataProvider.splice(elemIndex, 1);
	
}
	