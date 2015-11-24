//
//  UIWebViewController.m
//  UIWebViewANE
//
//  Created by I Nengah Januartha on 10/15/14.
//  Copyright (c) 2014 I Nengah Januartha. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

NSString *ON_PAGE_START = @"ON_PAGE_START";
NSString *ON_PAGE_LOADED = @"ON_PAGE_LOADED";
NSString *ON_PAGE_ERROR = @"ON_PAGE_ERROR";
NSString *ON_PROGRESS = @"ON_PROGRESS";

@implementation UIWebViewController

@synthesize x = _x;
@synthesize y = _y;
@synthesize width = _width;
@synthesize height = _height;

- (id)initWithFREContext:(FREContext)ctx
{
    if(self == nil)
    {
        self = [super init];
    }
    
    freContext = ctx;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)web
{
    FREDispatchStatusEventAsync(freContext, (uint8_t*)[ON_PAGE_START UTF8String], (uint8_t*)[[[[web request] URL] absoluteString] UTF8String]);
}

- (void) webViewDidFinishLoad:(UIWebView *)web
{
    FREDispatchStatusEventAsync(freContext, (uint8_t*)[ON_PAGE_LOADED UTF8String], (uint8_t*)[[[[web request] URL] absoluteString] UTF8String]);}

- (void) webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    FREDispatchStatusEventAsync(freContext, (uint8_t*)[ON_PAGE_ERROR UTF8String], (uint8_t*)[[error description] UTF8String]);}

- (void) setX:(int)x
{
    _x = x;
    
    CGRect frame = webView.frame;
    
    webView.frame = CGRectMake(_x, frame.origin.y, frame.size.width, frame.size.height);
}

- (int) x
{
    return _x;
}

- (void) setY:(int)y
{
    _y = y;
    
    CGRect frame = webView.frame;
    
    webView.frame = CGRectMake(frame.origin.x, _y, frame.size.width, frame.size.height);
    
}

- (int) y
{
    return _y;
}

- (void) setWidth:(uint)width
{
    _width = width;
    
    CGRect frame = webView.frame;
    
    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, _width, frame.size.height);
}

- (uint) width
{
    return _width;
}

- (void) setHeight:(uint)height
{
    _height = height;
    
    CGRect frame = webView.frame;
    
    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _height);
}

- (uint) height
{
    return _height;
}

- (void) open:(NSString *)urlPath x:(int)xPos y:(int)yPos w:(int)width h:(int)height
{
    _x = xPos;
    _y = yPos;
    _width = width;
    _height = height;
    
    rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(_x, _y, _width, _height)];
    [webView setDelegate:self];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]]];
    
    [[rootViewController view] addSubview:webView];}

- (void) loadURL:(NSString *)urlPath
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]]];
}

- (void) reload
{
    [webView reload];
}

- (void) goBack
{
    [webView goBack];
}

- (void) goForward
{
    [webView goForward];
}

- (void) goBackOrForward:(int)steps
{
    
}

- (void) close
{
    [webView removeFromSuperview];
    
    freContext = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
