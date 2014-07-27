import UrlPopup.UrlEvent;

import flash.events.*;
import flash.ui.Keyboard;
import mx.controls.Button;
import mx.events.*;
import mx.managers.PopUpManager;
import mx.validators.*;

private function init():void 
{
	sendButton.addEventListener(MouseEvent.CLICK, onButtonClick);
	urlInput.setFocus();
	urlInput.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	this.addEventListener(KeyboardEvent.KEY_UP, onWindowKeyUp);
}

// Click of the button
private function onButtonClick(e:MouseEvent):void 
{
	// If validator returns a valid url...
	if( urlValidator.validate().type == ValidationResultEvent.VALID ) 
	{
		var url:String = urlInput.text;
		// if the protocol is missing, add it!
		if ( url.indexOf("http://") != 0 && url.indexOf("https://") != 0) 
		{
			url = "http://" + url;
		}
		// Dispatch the "URL Entered" event
		this.dispatchEvent(new UrlEvent(UrlEvent.ENTERED, url));
		// ... and remove the popup
		closePopup();
	} 
	
	// otherwise select everything in the field
	else 
	{
		urlInput.selectAll();
		trace("no valid URL");
	}
}

// Send form on enter
private function onKeyUp(e:KeyboardEvent):void 
{
	if (e.keyCode == Keyboard.ENTER) 
	{
		onButtonClick(new MouseEvent(MouseEvent.CLICK));
	}
}

// Close popup with escape
private function onWindowKeyUp(e:KeyboardEvent):void 
{
	if (e.keyCode == Keyboard.ESCAPE) 
	{
		this.closePopup();
	}
}

private function closePopup():void 
{
	// Remove events
	this.removeEventListener(KeyboardEvent.KEY_UP, onWindowKeyUp);
	sendButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
	urlInput.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	
	// remove popup
	PopUpManager.removePopUp(this);         
}