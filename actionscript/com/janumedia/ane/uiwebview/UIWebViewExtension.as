package com.janumedia.ane.uiwebview
{
	import flash.desktop.NativeApplication;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class UIWebViewExtension
	{
		public static const EXTENSION_ID:String = "com.janumedia.ane.uiwebview";
		
		public static const ON_PAGE_START:String = "ON_PAGE_START";
		public static const ON_PAGE_LOADED:String = "ON_PAGE_LOADED";
		public static const ON_PAGE_ERROR:String = "ON_PAGE_ERROR";
		public static const ON_PROGRESS:String = "ON_PROGRESS";
		
		private var _context:ExtensionContext;
		
		public function UIWebViewExtension ()
		{
			if (!_context) _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
			
			if (isSupported) _context.addEventListener(StatusEvent.STATUS, onContextStatus, false, 0, true);
		}
		
		public final function get isSupported () : Boolean
		{
			return !!_context;
		}
		
		public final function getVersion () : String
		{
			if (!_context) return "";
			
			return String (_context.call("getVersion"));
		}
		
		public final function open (urlPath:String, xPos:int, yPos:int, width:int, height:int) : Boolean
		{
			if (!_context) return false;
			
			return _context.call("open", urlPath, xPos, yPos, width, height);
		}
		
		public final function loadURL (urlPath:String) : Boolean
		{
			if (!_context) return false;
			
			return _context.call("loadURL", urlPath);
		}
		
		public final function reload () : Boolean
		{
			if (!_context) return false;
			
			return _context.call("reload");
		}
		
		public final function goBack () : Boolean
		{
			if (!_context) return false;
			
			return _context.call("goBack");
		}
		
		public final function goForward () : Boolean
		{
			if (!_context) return false;
			
			return _context.call("goForward");
		}
		
		public final function goBackOrForward (steps:int) : Boolean
		{
			if (!_context) return false;
			
			return _context.call("goBackOrForward");
		}
		
		public final function set x (newX:int) : void
		{
			if (!_context) return;
			
			_context.call("x", newX);
		}
		
		public final function get x () : int
		{
			if (!_context) return 0;
			
			return int (_context.call("x"));
		}
		
		public final function set y (newY:int) : void
		{
			if (!_context) return;
			
			_context.call("y", newY);
		}
		
		public final function get y () : int
		{
			if (!_context) return 0;
			
			return int(_context.call("y"));
		}
		
		public final function set width (newW:int) : void
		{
			if (!_context) return;
			
			_context.call("width", newW);
		}
		
		public final function get width () : int
		{
			if (!_context) return 0;
			
			return int (_context.call("width"));
		}
		
		public final function set height (newH:int) : void
		{
			if (!_context) return;
			
			_context.call("height", newH);
		}
		
		public final function get height () : int
		{
			if (!_context) return 0;
			
			return int (_context.call("height"));
		}
		
		public final function close () : Boolean
		{
			if (!_context) return false;
			
			return _context.call("close");
		}
		
		public final function dispose () : void
		{
			if (!_context) return;
			
			_context.removeEventListener(StatusEvent.STATUS, onContextStatus);
			
			_context.dispose();
			
			_context = null;
		}
		
		private function onContextStatus(e:StatusEvent):void 
		{
			NativeApplication.nativeApplication.dispatchEvent (e);
		}
	}
}