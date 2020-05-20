package util
{
	import eventUtil.EventCenter;
	
	import laya.components.Script;
	import laya.events.Event;
	import laya.utils.Browser;
	
	import script.ViewManager;
	
	import ui.viewpage.PicCheckPanelUI;
	
	
	public class PictureCheckControl extends Script
	{
		private var uiSkin:PicCheckPanelUI;
		
		public var param:Object;
		
		public function PictureCheckControl()
		{
			super();
		}
		
		override public function onStart():void
		{
			uiSkin = this.owner as PicCheckPanelUI;
			
			uiSkin.closeBtn.on(Event.CLICK,this,onClosePanel);
			uiSkin.mainpanel.on(Event.CLICK,this,onClosePanel);
			//uiSkin.mainpanel.vScrollBarSkin = "";
			
			//uiSkin.mainpanel.hScrollBarSkin = "";
			
			//uiSkin.mainpanel.height = Browser.height;
			//uiSkin.mainpanel.width = Browser.width;
			uiSkin.mainpanel.hScrollBar.mouseWheelEnable = false;
			//uiSkin.yixingimg.visible = false;
		

			if(param != null)
			{
				this.uiSkin.img.skin = "http://large-thumbnail-image.oss-cn-hangzhou.aliyuncs.com/" + param.gpLicense + ".jpg";
							
			}		
			
		}
		
		
		public override function onDestroy():void
		{
			Laya.loader.clearTextureRes(this.uiSkin.img.skin);
		}
		private function onClosePanel():void
		{
			// TODO Auto Generated method stub
			ViewManager.instance.closeView(ViewManager.VIEW_PICTURE_CHECK);

		}
	}
}