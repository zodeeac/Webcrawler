package UrlPopup
{
	import mx.validators.*;
	
	public class UrlValidator extends Validator
	{
		public function UrlValidator()
		{
		}
		
		override protected function doValidation(value:Object):Array {
			var stringToValidate:String = value as String;
			var results:Array = new Array();
			
			results = super.doValidation(value);
			
			var regEx:RegExp = /(http[s]?\:\/\/){0,1}(w[3]\.){0,1}([a-zA-Zäöü\-]{2,}?)\.([a-zA-Z\.]{2,})/;
			
			if (!regEx.test(stringToValidate)) {
				results.push(new ValidationResult(true, null, "urlNotValid", "The URL is invalid!"));
			}
			
			return results;
		}
		
	}
	
	
	
	
}