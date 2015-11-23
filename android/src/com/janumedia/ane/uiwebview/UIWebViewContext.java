package com.janumedia.ane.uiwebview;

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class UIWebViewContext extends FREContext {

	UIWebViewDialog webDialog;
	
	@Override
	public Map<String, FREFunction> getFunctions() {
		
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
		
		map.put("getVersion", getVersion());
		map.put("open", open());
		map.put("close", close());
		map.put("loadURL", loadURL());
		map.put("reload", reload());
		map.put("goBack", goBack());
		map.put("goForward", goForward());
		map.put("goBackOrForward", goBackOrForward());
		map.put("x", updateXPos());
		map.put("y", updateYPos());
		map.put("width", updateWidth());
		map.put("height", updateHeight());
		
		return map;
	}
	
	private FREFunction getVersion() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				Log.v("TRACE", "getVersion " + UIWebViewExtension.VERSION);
				
				try {
					return FREObject.newObject(UIWebViewExtension.VERSION);
				} catch (FREWrongThreadException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction open() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				Log.v("TRACE", "open");
				
				try {
					
					String urlPath = args[0].getAsString();
					int xpos = args[1].getAsInt();
					int ypos = args[2].getAsInt();
					int w = args[3].getAsInt();
					int h = args[4].getAsInt();
					
					webDialog = new UIWebViewDialog(ctx, getActivity(), urlPath, xpos, ypos, w, h);
					webDialog.show();
					
					return FREObject.newObject(true);
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction close() {
		
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				Log.v("TRACE", "close");
				
				if(webDialog != null)
				{
					webDialog.dismiss();
					webDialog = null;
				}
				
				try {
					return FREObject.newObject(true);
				} catch (FREWrongThreadException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	private FREFunction loadURL() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				try {
					
					String urlPath = args[0].getAsString();
					if(webDialog != null)
					{
						webDialog.loadURL(urlPath);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	private FREFunction reload() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				if(webDialog != null)
				{
					webDialog.reload();
				}
				
				try {
					return FREObject.newObject(true);
				} catch (FREWrongThreadException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	private FREFunction goBack() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				if(webDialog != null)
				{
					webDialog.goBack();
				}
				
				try {
					return FREObject.newObject(true);
				} catch (FREWrongThreadException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction goForward() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				if(webDialog != null)
				{
					webDialog.goForward();
				}
				
				try {
					return FREObject.newObject(true);
				} catch (FREWrongThreadException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	private FREFunction goBackOrForward() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				try {
					
					int steps = args[0].getAsInt();
					if(webDialog != null)
					{
						webDialog.goBackOrForward(steps);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	private FREFunction updateXPos() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				try {
					
					if(webDialog != null)
					{
						if(args.length == 0)
						{
							return FREObject.newObject(webDialog.getXPos());
						}
						
						int newX = args[0].getAsInt();
						webDialog.updateXPos(newX);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction updateYPos() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				try {
					
					if(webDialog != null)
					{
						if(args.length == 0)
						{
							return FREObject.newObject(webDialog.getYPos());
						}
						
						int newY = args[0].getAsInt();
						
						webDialog.updateYPos(newY);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction updateWidth() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				try {
					
					if(webDialog != null)
					{
						if(args.length == 0)
						{
							return FREObject.newObject(webDialog.getWidth());
						}
						
						int newW = args[0].getAsInt();
						
						webDialog.updateWidth(newW);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}

	private FREFunction updateHeight() {
		return new FREFunction() {
			
			@Override
			public FREObject call(FREContext ctx, FREObject[] args) {
				
				try {
					
					if(webDialog != null)
					{
						if(args.length == 0)
						{
							return FREObject.newObject(webDialog.getHeight());
						}
						
						int newH = args[0].getAsInt();
						
						webDialog.updateHeight(newH);
						
						return FREObject.newObject(true);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FRETypeMismatchException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREInvalidObjectException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FREWrongThreadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return null;
			}
		};
	}
	
	/* for later support on JavaScript
	private FREFunction invokeJS() {
		// TODO Auto-generated method stub
		return null;
	}
	 */
	
	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

}
