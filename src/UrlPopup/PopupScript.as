import flash.events.MouseEvent;

import mx.events.*;
import mx.managers.PopUpManager;
import mx.validators.*;

private function init():void {
	sendButton.addEventListener(MouseEvent.CLICK, onButtonClick);
}

private function onButtonClick(e:MouseEvent):void {
	if( urlValidator.validate().type == ValidationResultEvent.VALID ) {
		PopUpManager.removePopUp(this);	
	} else {
		trace("no valid URL");
	}
}

private function closePopup():void {
	PopUpManager.removePopUp(this);         
}