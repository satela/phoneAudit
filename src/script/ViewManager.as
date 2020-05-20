package script
{
	import eventUtil.EventCenter;
	
	import laya.components.Script;
	import laya.display.Sprite;
	import laya.ui.View;
	import laya.utils.Browser;
	
	import ui.PopUpDialogUI;
	import ui.viewpage.PicCheckPanelUI;
	
	

	public class ViewManager
	{
		private static var _instance:ViewManager;
		
		private var viewContainer:Sprite;
		
		private var openViewList:Object;
		

		public static const VIEW_PICTURE_CHECK:String = "VIEW_PICTURE_CHECK";//图片预览

	

		public static const VIEW_POPUPDIALOG:String = "VIEW_POPUPDIALOG";//确认框

		public var viewDict:Object;
		public static function get instance():ViewManager
		{
			if(_instance == null)
				_instance = new ViewManager();
			return _instance;
		}
		
		public function ViewManager()
		{
			viewContainer = new Sprite();
			
			Laya.stage.addChild(viewContainer);
			
			var screenHeight:int = window.screen.height;
			var screenWidth:int = window.screen.width;
			
			//if(screenHeight < 1080)
			//	viewContainer.scaleY = screenHeight/1080;
			
			if(screenWidth < 1920)
			{
				//viewContainer.scaleX = screenWidth/1920;
				//viewContainer.x = (1920 - screenWidth)/2;
			}

			
			openViewList = {};
			
			viewDict = new Object();
			
			viewDict[VIEW_PICTURE_CHECK] = PicCheckPanelUI;
			viewDict[VIEW_POPUPDIALOG] = PopUpDialogUI;

			


		}
		
		public static function showAlert(mesg:String):void
		{
			Browser.window.alert(mesg);

		}
		public function openView(viewClass:String,closeOther:Boolean=false,params:Object = null):void
		{
			
			
			if(closeOther)
			{
				for each(var oldview in openViewList)
				{
					if(oldview != null)
					{
						viewContainer.removeChild(oldview);
						(oldview as View).destroy(true);
					}
					
				}
				openViewList = {};
			}
			
			if(viewDict[viewClass] == null)
				return;
			
			EventCenter.instance.event(EventCenter.OPEN_PANEL_VIEW,viewClass);
			
			if(openViewList[viewClass] != null)
				return;
			
			var view:View = new viewDict[viewClass]();
			view.param = params;
//			var control:Script = view.getComponent(Script);
//			if(control != null)
//			control["param"] = params;
			viewContainer.addChild(view);
			openViewList[viewClass] = view;
		}
		
		public function closeView(viewClass:String):void
		{
			if(openViewList[viewClass] == null)
			{
				return;
				showAlert("不存在的界面");
			}
			viewContainer.removeChild(openViewList[viewClass]);
			(openViewList[viewClass] as View).destroy(true);
			openViewList[viewClass] = null;
			delete openViewList[viewClass];
			EventCenter.instance.event(EventCenter.COMMON_CLOSE_PANEL_VIEW,viewClass);

		}
	}
}