//
//全局消息注册与发送，用事件机制完成
//
package eventUtil
{
	
	import laya.events.EventDispatcher;
	
	/**客户端内部事件的派发和接受用这个*/
	public class EventCenter extends EventDispatcher 
	{
		public static const MENU_CLICK:String = "MENU_CLICK";
		public static const OPEN_PANEL_VIEW:String = "OPEN_PANEL_VIEW";
		public static const COMMON_CLOSE_PANEL_VIEW:String = "COMMON_CLOSE_PANEL_VIEW";
		public static const REFRESH_REQUEST:String = "REFRESH_REQUEST";

		
		private static var _eventCenter:EventCenter;
		
		
	

		public static function get instance():EventCenter
		{
			if(_eventCenter == null)
			{
				_eventCenter = new EventCenter(new SingleForcer());
			}
			
			return _eventCenter;
		}
		
		public function EventCenter(force:SingleForcer)
		{
			
		}
		
	}
}

class SingleForcer{}
