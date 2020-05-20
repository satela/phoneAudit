package script.item
{
	import HttpRequestUtil;
	
	import eventUtil.EventCenter;
	
	import laya.events.Event;
	
	import script.ViewManager;
	
	import ui.items.RequestItemUI;
	
	public class AuditItem extends RequestItemUI
	{
		private var requestdata:Object;
		public function AuditItem()
		{
			super();
		}
		
		public function setData(data:*):void
		{
			requestdata = data;
			this.gp_name.text = data.gpName;
			this.rt_phone.text = data.createUserAccount;
			this.status.text = ["待审核","审核通过","审核拒绝"][data.rtResult];
			this.status.color = ["#0000FF","#00DE00","#FF0000"][data.rtResult];
			this.address.text = data.gpPolicyAddr;
			this.detailadd.text = data.gpAddr;
			this.code.text = data.socialCode;
			
			this.rt_time.text = data.rtDate;
			
			this.txtlicense.underline = true;
			
			this.passtxt.underline = true;
			
			this.refusetxt.underline = true;
			
			this.refusetxt.underlineColor = "#232323";
			
			this.passtxt.underlineColor = "#232323";
			this.txtlicense.underlineColor = "#232323";
			
			this.refusetxt.on(Event.CLICK,this,onrefuse);
			
			this.passtxt.on(Event.CLICK,this,onPassRequest);
			this.txtlicense.on(Event.CLICK,this,onShowPic);


		}
		
		private function onShowPic():void
		{
			ViewManager.instance.openView(ViewManager.VIEW_PICTURE_CHECK,false,requestdata);

		}
		private function onrefuse():void
		{
			ViewManager.instance.openView(ViewManager.VIEW_POPUPDIALOG,false,{msg:"确定拒绝该公司的申请吗？",caller:this,callback:confirmRefuse});
		}
		
		private function confirmRefuse(b:Boolean):void
		{
			if(b)
			{
				var param:String = "";
				for(var key in requestdata)
				{
					if(key != "rtResult" && key != "rtInfo")
						param += key + "=" + requestdata[key] + "&";
				}
				
				param += "rtResult=2";
				HttpRequestUtil.instance.Request(HttpRequestUtil.httpUrl + HttpRequestUtil.passGroupRequest + param,this,onrefuseBack,null,"get");
			}
		}
		
		private function onrefuseBack(data:*):void
		{
			var result:Object = JSON.parse(data as String);
			if(result.code == 200)
			{
				ViewManager.showAlert("操作成功");
				EventCenter.instance.event(EventCenter.REFRESH_REQUEST);

			}
			else
				ViewManager.showAlert(result.msg);
		}
		
		private function onPassRequest():void
		{
			ViewManager.instance.openView(ViewManager.VIEW_POPUPDIALOG,false,{msg:"确定同意该公司的申请吗？",caller:this,callback:confirmPass});
		}
		
		private function confirmPass(b:Boolean):void
		{
			if(b)
			{
				var param:String = "";
				for(var key in requestdata)
				{
					if(key != "rtResult" && key != "rtInfo")
						param += key + "=" + requestdata[key] + "&";
				}
				
				param += "rtResult=1";
				HttpRequestUtil.instance.Request(HttpRequestUtil.httpUrl + HttpRequestUtil.passGroupRequest + param,this,onrefuseBack,null,"get");
			}
		}
		
	}
}