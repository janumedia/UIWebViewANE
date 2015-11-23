package com.janumedia.ane.uiwebview;

import com.adobe.fre.FREContext;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.Window;
import android.view.WindowManager;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;

public class UIWebViewDialog extends Dialog {

	private static String ON_PAGE_START = "ON_PAGE_START";
	private static String ON_PAGE_LOADED = "ON_PAGE_LOADED";
	private static String ON_PAGE_ERROR = "ON_PAGE_ERROR";
	private static String ON_PROGRESS = "ON_PROGRESS";
	
	private FREContext freCtx;
	private RelativeLayout view;
	private WebView web;
	
	public UIWebViewDialog(FREContext ctx, Context context, String urlPath, int xpos, int ypos, int w, int h) {
		
		super(context);
		
		freCtx = ctx;
		
		Window win = getWindow();
		win.requestFeature(Window.FEATURE_NO_TITLE);
		win.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
		win.clearFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND);
		// disable activity modal ; allow AIR stage touch event
		win.setFlags(WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL, WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL);
		
		WindowManager.LayoutParams wParams = win.getAttributes();
		wParams.gravity = Gravity.TOP | Gravity.LEFT;
		wParams.x = xpos;
		wParams.y = ypos;
		
		win.setAttributes(wParams);
		
		web = new WebView(getContext());
		web.setPivotX(0);
		web.setPivotY(0);
		web.setPadding(0, 0, 0, 0);
		web.setWebChromeClient(new WebChromeClient()
		{
			@Override
			public void onProgressChanged(WebView view, int newProgress) {
				super.onProgressChanged(view, newProgress);
				
				freCtx.dispatchStatusEventAsync(ON_PROGRESS, "" + newProgress);
			}
		});
		web.setWebViewClient(new WebViewClient()
		{
			
			@Override
			public void onPageStarted(WebView view, String url, Bitmap favicon) {
				super.onPageStarted(view, url, favicon);
				
				freCtx.dispatchStatusEventAsync(ON_PAGE_START, url);
			}
			
			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);
				
				freCtx.dispatchStatusEventAsync(ON_PAGE_LOADED, url);
			}
			
			@Override
			public void onReceivedError(WebView view, int errorCode,
					String description, String failingUrl) {
				super.onReceivedError(view, errorCode, description, failingUrl);
				
				freCtx.dispatchStatusEventAsync(ON_PAGE_ERROR, errorCode + "::" + description);
			}
		});

		web.loadUrl(urlPath);
		
		RelativeLayout.LayoutParams lParams = new RelativeLayout.LayoutParams(w, h);
		view = new RelativeLayout(getContext());
		view.addView(web, lParams);
		
		setContentView(view);
	}
	
	public void loadURL (String urlPath)
	{
		web.loadUrl(urlPath);
	}
	
	public void reload ()
	{
		web.reload();
	}

	public void goBack() {
		web.goBack();
	}

	public void goForward() {
		web.goForward();
	}
	
	public void goBackOrForward(int steps) {
		web.goBackOrForward(steps);
	}

	public void updateXPos(int newX) {
		WindowManager.LayoutParams wParams = getWindow().getAttributes();
		wParams.x = newX;
		
		getWindow().setAttributes(wParams);
	}
	
	public void updateYPos(int newY) {
		WindowManager.LayoutParams wParams = getWindow().getAttributes();
		wParams.y = newY;
		
		getWindow().setAttributes(wParams);
	}
	
	public void updateWidth(int newW) {
		RelativeLayout.LayoutParams lParams = (LayoutParams) web.getLayoutParams();
		lParams.width = newW;
		
		web.setLayoutParams(lParams);
	}
	
	public void updateHeight(int newH) {
		RelativeLayout.LayoutParams lParams = (LayoutParams) web.getLayoutParams();
		lParams.height = newH;
		
		web.setLayoutParams(lParams);
	}

	public int getXPos() {
		return getWindow().getAttributes().x;
	}
	
	public int getYPos() {
		return getWindow().getAttributes().y;
	}
	
	public int getWidth() {
		return web.getLayoutParams().width;
	}
	
	public int getHeight() {
		return web.getLayoutParams().height;
	}

}
