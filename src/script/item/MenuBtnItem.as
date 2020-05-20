package script.item
{
	import eventUtil.EventCenter;
	
	import laya.events.Event;
	
	import ui.items.MenuBtnUI;
	
	public class MenuBtnItem extends MenuBtnUI
	{
		public var menudata:Object;
		public function MenuBtnItem()
		{
			super();
		}
		
		public function setData(data:*):void
		{
			menudata = data;
			this.btn.label = data.menu_name;
			
			this.btn.on(Event.CLICK,this,onClickBtn);
			
		}
		
		public function setSelected(bool:Boolean):void
		{
			this.btn.selected = bool;
		}
		private function onClickBtn():void
		{
			EventCenter.instance.event(EventCenter.MENU_CLICK,menudata);
		}
	}
}