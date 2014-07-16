import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.IVisualElement;

import spark.components.VGroup;

private var _image:String;
private var _list:ImageList;

public function set image(image:String):void
{
	_image = image;
	this.picture.source = _image;
}

public function get image():String
{
	return _image;
}

public function set list(list:ImageList):void
{
	_list = list;
}

private function init():void
{
	button.addEventListener(MouseEvent.CLICK, remove);
}

private function remove(event:Event):void
{
	trace("removed");
	_list.remove(this);
}