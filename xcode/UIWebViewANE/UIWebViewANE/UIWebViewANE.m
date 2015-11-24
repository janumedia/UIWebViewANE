//
//  UIWebViewANE.m
//  UIWebViewANE
//
//  Created by I Nengah Januartha on 10/15/14.
//  Copyright (c) 2014 I Nengah Januartha. All rights reserved.
//

#import "UIWebViewController.h"
#import "FlashRuntimeExtensions.h"

static NSString *VERSION = @"1.0.0";

UIWebViewController *webController;

FREObject getVersion (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        const char *str = [VERSION UTF8String];
        
        FREObject result = nil;
        FRENewObjectFromUTF8((uint32_t)(strlen(str)+1), (const uint8_t*)str, &result);
        return result;
    }
}

FREObject openUIWebView (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        if(webController == nil)
        {
            webController = [[UIWebViewController alloc] initWithFREContext:ctx];
        }
        
        uint32_t urlLength;
        const uint8_t *url;
        int32_t x;
        int32_t y;
        uint32_t width;
        uint32_t height;
        
        FREGetObjectAsUTF8(args[0], &urlLength, &url);
        FREGetObjectAsInt32(args[1], &x);
        FREGetObjectAsInt32(args[2], &y);
        FREGetObjectAsUint32(args[3], &width);
        FREGetObjectAsUint32(args[4], &height);
        
        NSString *urlPath = [NSString stringWithUTF8String:(char*)url];
        
        [webController open:urlPath x:x y:y w:width h:height];
        
        FREObject result = nil;
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}

FREObject loadURL (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        uint32_t urlLength;
        const uint8_t *url;
        
        FREGetObjectAsUTF8(args[0], &urlLength, &url);
        
        [webController loadURL:[NSString stringWithUTF8String:(char*)url]];
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}

FREObject reload (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        [webController reload];
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}

FREObject goBack (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        [webController goBack];
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}

FREObject goForward (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        [webController goForward];
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}

FREObject goBackOrForward (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        FREObject result = nil;
        return result;
    }
}


FREObject xpos (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        if(argc == 0)
        {
            
            FRENewObjectFromInt32(webController.x, &result);
            
            return result;
        }
        
        int32_t newX;
        
        FREGetObjectAsInt32(args[0], &newX);
        
        webController.x = newX;
        
        return result;
    }
}

FREObject ypos (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        if(argc == 0)
        {
            
            FRENewObjectFromInt32(webController.y, &result);
            
            return result;
        }
        
        int32_t newY;
        
        FREGetObjectAsInt32(args[0], &newY);
        
        webController.y = newY;
        
        return result;
    }
}

FREObject width (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        if(argc == 0)
        {
            
            FRENewObjectFromInt32(webController.width, &result);
            
            return result;
        }
        
        int32_t newWidth;
        
        FREGetObjectAsInt32(args[0], &newWidth);
        
        webController.width = newWidth;
        
        return result;
    }
}

FREObject height (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        if(argc == 0)
        {
            
            FRENewObjectFromInt32(webController.height, &result);
            
            return result;
        }
        
        int32_t newHeight;
        
        FREGetObjectAsInt32(args[0], &newHeight);
        
        webController.height = newHeight;
        
        return result;
    }
}

FREObject closeUIWebView (FREContext ctx, void *data, uint32_t argc, FREObject args[])
{
    @autoreleasepool {
        
        FREObject result = nil;
        
        if(webController == nil) return result;
        
        [webController close];
        
        webController = nil;
        
        FRENewObjectFromBool(YES, &result);
        
        return result;
    }
}


void UIWebViewANEContextInit (void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFuncToTest, const FRENamedFunction **funcToset)
{
    *numFuncToTest = 12;
    
    FRENamedFunction *func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*(*numFuncToTest));
    
    func[0].name = (const uint8_t*)"getVersion";
    func[0].functionData = NULL;
    func[0].function = &getVersion;
    
    func[1].name = (const uint8_t*)"open";
    func[1].functionData = NULL;
    func[1].function = &openUIWebView;
    
    func[2].name = (const uint8_t*)"loadURL";
    func[2].functionData = NULL;
    func[2].function = &loadURL;
    
    func[3].name = (const uint8_t*)"reload";
    func[3].functionData = NULL;
    func[3].function = &reload;
    
    func[4].name = (const uint8_t*)"goBack";
    func[4].functionData = NULL;
    func[4].function = &goBack;
    
    func[5].name = (const uint8_t*)"goForward";
    func[5].functionData = NULL;
    func[5].function = &goForward;
    
    func[6].name = (const uint8_t*)"goBackOrForward";
    func[6].functionData = NULL;
    func[6].function = &goBackOrForward;
    
    func[7].name = (const uint8_t*)"x";
    func[7].functionData = NULL;
    func[7].function = &xpos;
    
    func[8].name = (const uint8_t*)"y";
    func[8].functionData = NULL;
    func[8].function = &ypos;
    
    func[9].name = (const uint8_t*)"width";
    func[9].functionData = NULL;
    func[9].function = &width;
    
    func[10].name = (const uint8_t*)"height";
    func[10].functionData = NULL;
    func[10].function = &height;
    
    func[11].name = (const uint8_t*)"close";
    func[11].functionData = NULL;
    func[11].function = &closeUIWebView;
    
    *funcToset = func;
}

void UIWebViewANEContextFinal (FREContext ctx)
{
    return;
}

void UIWebViewANEExtInit (void **extData, FREContextInitializer *ctxInit, FREContextFinalizer *ctxFinal)
{
    *extData = NULL;
    *ctxInit = &UIWebViewANEContextInit;
    *ctxFinal = &UIWebViewANEContextFinal;
}

void UIWebViewANEExtFinal (void *extData)
{
    return;
}