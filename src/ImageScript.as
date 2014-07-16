import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

private var _image:String;

public function set image(image:String):void
{
	_image = image;
	this.picture.source = _image;
}

public function get image():String
{
	return _image;
}

private function init():void
{
	button.addEventListener(MouseEvent.CLICK, remove);
}

private function remove(event:Event):void
{
	trace("removed");
}