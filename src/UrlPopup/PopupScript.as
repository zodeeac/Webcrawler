import UrlPopup.UrlEvent;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import mx.controls.Button;
import mx.events.*;
import mx.managers.PopUpManager;
import mx.validators.*;

private function init():void 
{
	sendButton.addEventListener(MouseEvent.CLICK, onButtonClick);
}

private function onButtonClick(e:MouseEvent):void 
{
	if( urlValidator.validate().type == ValidationResultEvent.VALID ) 
	{
		var url:String = urlInput.text;
		// if the protocol is missing, add it!
		if ( url.indexOf("http://") != 0 && url.indexOf("https://") != 0) 
		{
			url = "http://" + url;
		}
		this.dispatchEvent(new UrlEvent(UrlEvent.ENTERED, url));
		PopUpManager.removePopUp(this);	
	} 
	else 
	{
		trace("no valid URL");
	}
}

private function closePopup():void 
{
	PopUpManager.removePopUp(this);         
}