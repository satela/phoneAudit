package
{	
	import laya.components.Script;
	import laya.display.Input;
	import laya.display.Scene;
	import laya.display.Stage;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.ui.Button;
	import laya.utils.Browser;
	
	import HttpRequestUtil;
	
	import ui.LogPanelUI;
	
	import UtilTool;
	
	public class LogPanelControl extends Script
	{
		private var uiSKin:LogPanelUI;
		public var param:Object;

		public function LogPanelControl()
		{
			//super();
		}
		
		override public function onStart():void
		{
			uiSKin = this.owner as LogPanelUI;
			//uiSKin.closebtn .on(Event.CLICK,this,onCloseScene);
			//uiSKin.bgimg.alpha = 0.95;
			
			uiSKin.mainpanel.hScrollBarSkin = "";
			uiSKin.mainpanel.width = Browser.width;
			//uiSKin.mainpanel.height = Browser.height;
			uiSKin.mainpanel.vScrollBarSkin = "";

			
			uiSKin.input_account.maxChars = 11;
			//uiSKin.input_account.restrict = "0-9";
			
			uiSKin.input_pwd.maxChars = 20;
			uiSKin.input_pwd.type = Input.TYPE_PASSWORD;
			
			
			uiSKin.txt_reg.underline = true;
			uiSKin.txt_reg.underlineColor =  "#121212";
			
			uiSKin.txt_forget.underline = true;
			uiSKin.txt_forget.underlineColor =  "#121212";
			
			//uiSKin.txt_reg.on(Event.CLICK,this,onRegister);
			//uiSKin.txt_forget.on(Event.CLICK,this,onResetpwd);

			uiSKin.btn_login.on(Event.CLICK,this,onLogin);
			
			uiSKin.input_account.on(Event.KEY_DOWN,this,onAccountKeyUp);

			uiSKin.input_pwd.on(Event.KEY_DOWN,this,onAccountKeyUp);
			
			uiSKin.input_account.focus = true;
			
			var account:String = UtilTool.getLocalVar("useraccount","0");
			var pwd:String = UtilTool.getLocalVar("userpwd","0");
			if(account != "0" && pwd != "0" && account != "" && pwd != "")
			{
				var param:String = "loginname=" + account +"&pwd=" + pwd;
				HttpRequestUtil.instance.Request(HttpRequestUtil.httpUrl + HttpRequestUtil.loginInUrl,this,onAutoLoginBack,param,"post");
			}

		}
		
		private function onResizeBrower():void
		{
			
			
			uiSKin.mainpanel.height = Browser.height;
			uiSKin.mainpanel.width = Browser.width;
			
		}
		
		private function onAccountKeyUp(e:Event):void
		{
			if(e.keyCode == Keyboard.TAB)
			{
				if(uiSKin.input_account.focus)
					uiSKin.input_pwd.focus = true;
				else if(uiSKin.input_pwd.focus)
					uiSKin.input_account.focus = true;
			}
			if(e.keyCode == Keyboard.ENTER)
			{
				onLogin();
			}
		}
		private function onLogin():void
		{
			// TODO Auto Generated method stub
			if(uiSKin.input_account.text == "")
			{
				Browser.window.alert("请填写正确的账号");
				return;
			}
			if(uiSKin.input_pwd.text.length < 6)
			{
				Browser.window.alert("密码位数至少是6位");
				return;
			}
			
			var param:String = "loginname=" + uiSKin.input_account.text + "&pwd=" + uiSKin.input_pwd.text;
			HttpRequestUtil.instance.Request(HttpRequestUtil.httpUrl + HttpRequestUtil.loginInUrl,this,onLoginBack,param,"post");
		}
		
		private function onAutoLoginBack(data:Object):void
		{
			
			var result:Object = JSON.parse(data as String);
			if(result.code == 200)
			{
							
				Scene.open("viewpage/MainPage.scene");
				
			}
			
		}
		
		private function onLoginBack(data:Object):void
		{
			
			var result:Object = JSON.parse(data as String);
			if(result.code == 200)
			{
				

				//ViewManager.showAlert("登陆成功");
				//EventCenter.instance.event(EventCenter.LOGIN_SUCESS, uiSKin.input_account.text);
				UtilTool.setLocalVar("useraccount",uiSKin.input_account.text);
				UtilTool.setLocalVar("userpwd",uiSKin.input_pwd.text);
				
				Scene.open("viewpage/MainPage.scene");
				//Userdata.instance.loginTime = (new Date()).getTime();
				//UtilTool.setLocalVar("loginTime",Userdata.instance.loginTime);
				
				//ViewManager.instance.closeView(ViewManager.VIEW_lOGPANEL);
				//ViewManager.instance.openView(ViewManager.VIEW_FIRST_PAGE);
			}
			
		}
		private function onRegister():void
		{
			// TODO Auto Generated method stub
			//ViewManager.instance.openView(ViewManager.VIEW_REGPANEL,true);

		}
		
		private function onResetpwd():void
		{
			//ViewManager.instance.openView(ViewManager.VIEW_CHANGEPWD,false);

		}
		override public function onEnable():void
		{
		}
		
		
		private function onCloseScene():void
		{
			// TODO Auto Generated method stub
			//Scene.close("login/LogPanel.scene");
			//EventCenter.instance.off(EventCenter.BROWER_WINDOW_RESIZE,this,onResizeBrower);

			//ViewManager.instance.closeView(ViewManager.VIEW_lOGPANEL);
			//ViewManager.instance.openView(ViewManager.VIEW_FIRST_PAGE);
		}		
		
	}
}