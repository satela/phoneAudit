package {
	import laya.display.Scene;
	import laya.display.Stage;
	import laya.net.AtlasInfoManager;
	import laya.net.ResourceVersion;
	import laya.net.URL;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Stat;
	import laya.utils.Utils;
	
	public class Main {
		public function Main() {
			//根据IDE设置初始化引擎		
			if (window["Laya3D"]) window["Laya3D"].init(1920, 1080);
			else Laya.init(1920, 1080, Laya["WebGL"]);
			//Laya["Physics"] && Laya["Physics"].enable();
			//Laya["DebugPanel"] && Laya["DebugPanel"].enable();
			Laya.stage.scaleMode = Stage.SCALE_FIXED_WIDTH;
			Laya.stage.screenMode =  Stage.SCREEN_HORIZONTAL; //GameConfig.screenMode;
			Laya.stage.alignV =  "middle";//GameConfig.alignV;
			Laya.stage.alignH = "center";//
			
//			if(Browser.width > Laya.stage.width)
//				Laya.stage.alignH = "center";
//			else
//				Laya.stage.alignH = "left";
			//兼容微信不支持加载scene后缀场景
			URL.exportSceneToJson = GameConfig.exportSceneToJson;
			
			//打开调试面板（IDE设置调试模式，或者url地址增加debug=true参数，均可打开调试面板）
			if (GameConfig.debug || Utils.getQueryString("debug") == "true") Laya.enableDebugPanel();
			if (GameConfig.physicsDebug && Laya["PhysicsDebugDraw"]) Laya["PhysicsDebugDraw"].enable();
			if (GameConfig.stat) Stat.show();
			Laya.alertGlobalError = true;
			
			//激活资源版本控制，版本文件由发布功能生成
			ResourceVersion.enable("version.json", Handler.create(this, this.onVersionLoaded), ResourceVersion.FILENAME_VERSION);
		}
		
		private function onVersionLoaded():void {
			//激活大小图映射，加载小图的时候，如果发现小图在大图合集里面，则优先加载大图合集，而不是小图
			AtlasInfoManager.enable("fileconfig.json", Handler.create(this, this.onConfigLoaded));
		}
		
		private function onConfigLoaded():void {
			//加载场景
		GameConfig.startScene && Scene.open("LogPanel.scene");
			//GameConfig.startScene && Scene.open("viewpage/MainPage.scene");

		}
	}
}