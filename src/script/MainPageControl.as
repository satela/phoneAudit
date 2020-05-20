package script
{
	import laya.components.Script;
	import laya.display.Scene;
	import laya.events.Event;
	import laya.utils.Handler;
	
	import model.MenuData;
	
	import script.item.MenuBtnItem;
	
	import ui.viewpage.GroupAuditViewUI;
	import ui.viewpage.MainPageUI;
	
	public class MainPageControl extends Script
	{
		private var uiskin:MainPageUI;
		private var curMenudata:Object;
		
		public var viewDict:Object = {
			"GroupAuditViewUI":GroupAuditViewUI
		}
		public function MainPageControl()
		{
			super();
		}
		
		override public function onStart():void
		{
			uiskin = this.owner as MainPageUI;
			
			uiskin.menulist.itemRender = MenuBtnItem;
			uiskin.menulist.vScrollBarSkin = "";
			uiskin.menulist.selectEnable = false;
			uiskin.menulist.spaceY = 0;
			uiskin.menulist.renderHandler = new Handler(this, updateMenuItem);
			
			uiskin.menulist.array = JSON.parse(MenuData.MENUS) as Array;
			
			uiskin.account.text = "用户名:" + UtilTool.getLocalVar("useraccount","0");
			
			uiskin.quitBtn.on(Event.CLICK,this,onQuitUser);
			
			if(uiskin.menulist.array.length > 0)
			{
				onclickMenu(uiskin.menulist.array[0]);
				(uiskin.menulist.cells[0] as MenuBtnItem).setSelected(true);
			}
			
		}
		
		private function onQuitUser():void
		{
			UtilTool.setLocalVar("useraccount","");
			UtilTool.setLocalVar("userpwd","");
			
			 Scene.open("LogPanel.scene");

		}
		private function onclickMenu(data:Object):void
		{
			if(curMenudata == data)
				return;
			
			curMenudata = data;
			
			while(uiskin.container.numChildren > 0)
				uiskin.container.removeChildAt(0);
			for(var i:int=0;i < uiskin.menulist.cells.length;i++)
			{
				(uiskin.menulist.cells[i] as MenuBtnItem).setSelected(data == (uiskin.menulist.cells[i] as MenuBtnItem).menudata);
			}
			var view = new viewDict[data.menu_page];
			
			uiskin.container.addChild(view);
		}
		private function updateMenuItem(cell:MenuBtnItem):void
		{
			cell.setData(cell.dataSource);
		}
		
	}
}