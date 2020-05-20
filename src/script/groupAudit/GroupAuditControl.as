package script.groupAudit
{
	import HttpRequestUtil;
	
	import eventUtil.EventCenter;
	
	import laya.components.Script;
	import laya.events.Event;
	import laya.utils.Handler;
	
	import script.item.AuditItem;
	import script.item.MenuBtnItem;
	
	import ui.viewpage.GroupAuditViewUI;
	import ui.viewpage.MainPageUI;
	
	public class GroupAuditControl extends Script
	{
		private var uiskin:GroupAuditViewUI;
		
		public function GroupAuditControl()
		{
			super();
		}
		
		override public function onStart():void
		{
			uiskin = this.owner as GroupAuditViewUI;
			
			uiskin.rtInfoInput.text = "";
			
			uiskin.statusRadio.selectedIndex = 3;
			
			uiskin.requestlist.itemRender = AuditItem;
			//uiskin.requestlist.vScrollBarSkin = "";
			uiskin.requestlist.selectEnable = false;
			uiskin.requestlist.spaceY = 0;
			uiskin.requestlist.renderHandler = new Handler(this, updateAuditItem);
			uiskin.requestlist.array = [];
			
			getRequestList();
			
			uiskin.searchBtn.on(Event.CLICK,this,getRequestList);
			
			EventCenter.instance.on(EventCenter.REFRESH_REQUEST,this,getRequestList);
		}
		
		private function updateAuditItem(cell:AuditItem):void
		{
			cell.setData(cell.dataSource);
		}
		
		private function getRequestList():void
		{
			
			var param:String = "gpName=" + uiskin.rtInfoInput.text + "&rtResult=" + uiskin.statusRadio.selectedIndex;
			HttpRequestUtil.instance.Request(HttpRequestUtil.httpUrl + HttpRequestUtil.getGroupRequestList + param,this,ongetDataBack,null,null);

			
		}
		
		private function ongetDataBack(data:*):void
		{
			var result:Object = JSON.parse(data as String);
			if(result.code == 0)
			{
				uiskin.requestlist.array = result.data;
			}
		}
	}
}