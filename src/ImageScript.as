import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.List;
import mx.core.IVisualElement;

import spark.components.VGroup;

private var _image:Bitmap;
private var _list:ImageList;
private var _data:Object;

override public function set data(data:Object):void {
	this._data = data;
	if (data == null)
	{
		// don't execute if no data is commited!
		return;
	}
	this._list = data.list as ImageList;
	this.image = data.image as Bitmap;
}

public function set image(image:Bitmap):void
{
	_image = image;
	this.picture.source = image.bitmapData;
}

public function get image():Bitmap
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