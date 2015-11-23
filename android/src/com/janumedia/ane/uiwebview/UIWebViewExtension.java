package com.janumedia.ane.uiwebview;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class UIWebViewExtension implements FREExtension {

	public static String VERSION = "1.0.0";
	
	@Override
	public FREContext createContext(String arg) {
		
		Log.v("TRACE", "createContext " + VERSION);
		
		return new UIWebViewContext ();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
