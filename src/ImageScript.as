import flash.display.Bitmap;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.List;
import mx.core.IVisualElement;

import spark.components.VGroup;

private var _image:String;
private var _list:ImageList;
private var _data:Object;

override public function set data(data:Object):void {
	this._data = data;
	if (data == null) return; // don't execute if no data is commited!
	this._list = data.list as ImageList;
	this.image = data.image as String;
}

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
	_list.removeImage(this._data);
}