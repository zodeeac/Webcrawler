package Controls
{	
	import flash.display.Bitmap;
	
	import mx.collections.ArrayList;
	import mx.controls.Button;
	import mx.core.ClassFactory;
	import mx.core.FlexGlobals;
	
	import spark.components.List;
	import Image.ImageElement;
	
	public class ImageList extends List
	{
		public function ImageList()
		{
			super();
			this.dataProvider = new ArrayList();
			this.itemRenderer = new ClassFactory(ImageElement);
		}
		
		public function addImage (image:Bitmap):void {
			this.dataProvider.addItem({"image": image, "list": this});
		}
		
		public function removeImage (content:Object):void 
		{
			(this.dataProvider as ArrayList).removeItem(content);
		}
		
		public function clearList ():void {
			this.dataProvider.removeAll();
		}
	}
}