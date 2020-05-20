package
{
	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.ui.View;
	import laya.utils.Browser;
	
	
	public class HttpRequestUtil
	{
		private static var _instance:HttpRequestUtil;
		
		public static var httpUrl:String =  "http://47.111.152.226:8060/";//"../scfy/";//http://www.cmyk.com.cn/scfy/" ;//	"http://47.98.218.56/scfy/"; //"http://dhs3iy.natappfree.cc/";//
		//public static var httpUrl:String =  "http://127.0.0.1:8080/";//"../scfy/";//http://www.cmyk.com.cn/scfy/" ;//	"http://47.98.218.56/scfy/"; //"http://dhs3iy.natappfree.cc/";//

		public static const loginInUrl:String = "login/login?";
		
		public static const getGroupRequestList:String = "requestInfo/loadAllAuditComapny?";
		public static const passGroupRequest:String = "requestInfo/passRequest?";


		public static function get instance():HttpRequestUtil
		{
			if(_instance == null)
				_instance = new HttpRequestUtil();
			return _instance;
		}
		
		public function HttpRequestUtil()
		{
			
		}
		
		private function newRequest(url:String,caller:Object=null,complete:Function=null,param:Object=null,requestType:String="text",onProgressFun:Function = null):void{
			
			var request:HttpRequest=new HttpRequest();
			request.on(Event.PROGRESS, this, function(e:Object)
			{
				if(onProgressFun != null)
					onProgressFun(e);
			});
			request.on(Event.COMPLETE, this,onRequestCompete,[caller, complete,request]);
			
			//var self:HttpModel=this;
			function checkOver(url:String,caller:Object,complete:Function,param:Object,requestType:String,request:HttpRequest){
				onHttpRequestError(url,caller,complete,param,requestType,request);
			}
			Laya.timer.once(5000,request,checkOver,[url,caller,complete,param,requestType,request]);
					
			
			request.on(Event.ERROR, this, onHttpRequestError,[url,caller,complete,param,requestType,request]);
			if(param!=null){
				if(param is String){
					
				}else if(param is ArrayBuffer){
					
				}else{
					var query:Array=[];
					for(var k in param){
						
						query.push(k+"="+encodeURIComponent(param[k]));
					}
					param=query.join("&");
				}
			}
			console.log(url+param);
			request["retrytime"]=0;
			request.send(url, param, requestType?'post':'get', "text");
		}
		
		private function onHttpRequestError(url:String,caller:Object,complete:Function,param:Object,requestType:String,request:HttpRequest,e:Object=null):void
		{
			//ViewManager.showAlert("您的网络出了个小差，请重试！");
		}
		
		private function onHttpRequestProgress(e:Object=null):void
		{
			trace(e)
		}
		
		private function onRequestCompete(caller:Object,complete:Function,request:HttpRequest,data:Object):void
		{
			
			Laya.timer.clearAll(request);
			// TODO Auto Generated method stub
			if(caller&&complete)complete.call(caller,data);
			request.offAll();
		}
		
		public  function Request(url:String,caller:Object=null,complete:Function=null,param:Object=null,type:String="get",onProgressFun:Function = null,showwaiting:Boolean=true):void{
			
			newRequest(url,caller,complete,param,type);
		}
		// --- Static Functions ------------------------------------------------------------------------------------------------------------------------------------ //
		public  function RequestBin(url:String,caller:Object=null,complete:Function=null,param:Object=null):void{
			newRequest(url,caller,complete,param,"arraybuffer");
		}
		
	}
}