//
//  UIWebViewController.h
//  UIWebViewANE
//
//  Created by I Nengah Januartha on 10/15/14.
//  Copyright (c) 2014 I Nengah Januartha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"

@interface UIWebViewController : UIViewController <UIWebViewDelegate>
{
    FREContext freContext;
    UIViewController *rootViewController;
    UIWebView *webView;
}

@property (readwrite) int x;
@property int y;
@property uint width;
@property uint height;

- (id)initWithFREContext:(FREContext) ctx;
- (void) open:(NSString *) urlPath x:(int) xPos y:(int) yPos w:(int) width h:(int) height;
- (void) loadURL:(NSString*) urlPath;
- (void) reload;
- (void) goBack;
- (void) goForward;
- (void) goBackOrForward:(int) steps;
- (void) close;

@end
