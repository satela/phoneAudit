package
{
	import laya.filters.ColorFilter;
	import laya.maths.Point;
	import laya.net.LocalStorage;
	import laya.utils.Browser;
	
	
	public class UtilTool
	{
		public static function oneCutNineAdd(fnum:Number):Number
		{
			var numstr:String = fnum.toFixed(1);
			var dotnum:int = parseInt(numstr.split(".")[1]);
			
			if(dotnum == 1)
				return parseInt(numstr.split(".")[0]);
			else if(dotnum == 9)
				return parseInt(numstr.split(".")[0]) + 1;
			else
				return parseFloat(numstr);

		}
		
		private static var grayscaleMat:Array = [
			0.3086, 0.6094, 0.0820, 0, 0, 
			0.3086, 0.6094, 0.0820, 0, 0, 
			0.3086, 0.6094, 0.0820, 0, 0, 
			0, 0, 0, 1, 0];
		
		//创建一个颜色滤镜对象，灰图
		public static var grayscaleFilter:ColorFilter = new ColorFilter(grayscaleMat);
		
		

		/**
		 *获取本地记录的内容 
		 * @param key
		 * @param defaultValue 默认值，会根据默认值int,float,string自动格式化返回值
		 * @return 
		 * 
		 */		
		public static function getLocalVar(key:String,defaultValue:*= null):*{
			var v:String=laya.net.LocalStorage.getItem(key);
			if(v===null){
				if(defaultValue==null)return null;
				v=defaultValue;
				laya.net.LocalStorage.setItem(key,v+"");
				return v;
			}
			
			if(defaultValue!=null)if(Math.floor(defaultValue)===defaultValue){
				if(v == "")
					v = "0"
				return parseInt(v); 
			}else if (parseFloat(defaultValue+"")===defaultValue){
				if(v == "")
					v = "0"
				return parseFloat(v);
			}
			return v;
		}
		public static function setLocalVar(key:String,value:*):void{
			//清除
			if(value==null){
				removeLocalVar(key);
				return;
			}
			LocalStorage.setItem(key,value+"");
		}
		public static function removeLocalVar(key:String):void{
			LocalStorage.removeItem(key);
		}
		
		public static function formatFullDateTime(date:Date,isFull:Boolean = true):String  
		{  
			var datestr:String = "";
			datestr += date.getFullYear() + "-" ;
			if((date.getMonth()+1) >= 10)
				datestr += (date.getMonth()+1) + "-";
			else
				datestr += "0" + (date.getMonth()+1) + "-";
			
			if(date.getDate() >= 10)
				datestr += date.getDate();
			else
				datestr += "0" + date.getDate();
			if(isFull == false)
				return datestr;
			
			datestr += " ";
			
			
			if(date.getHours() >= 10)
				datestr += date.getHours() + ":";
			else
				datestr += "0" + date.getHours() + ":";
			
			if(date.getMinutes() >= 10)
				datestr += date.getMinutes() + ":";
			else
				datestr += "0" + date.getMinutes() + ":";
			
			if(date.getSeconds() >= 10)
				datestr += date.getSeconds();
			else
				datestr += "0" + date.getSeconds();
			return datestr;
		}  
		
		
		public function UtilTool()
		{
		}
		
	}
}