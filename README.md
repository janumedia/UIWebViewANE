UIWebView / WebView ANE for Android
======================================

UIWebView / WebView Adobe AIR Native Extension for iOS Android applications

Also can be use as alternative to StageWebView

Version
---------

This is version 1.0.0 of this extension.

Extension ID
---------
```
<extensionID>com.janumedia.ane.uiwebview</extensionID>
```

Usage
---------

```
webExtension:UIWebViewExtension = new UIWebViewExtension;
webExtension.open("http://kompas.com", 5, 200, 350, 400);

```

Available Methods

```

webExtension.getVersion (); // return String current ANE versionwebExtension.
webExtension.open (urlPath:String, xPos:int, yPos:int, width:int, height:int) : Boolean
webExtension.loadURL (urlPath:String) : Boolean
webExtension.reload () : Boolean
webExtension.goBack () : Boolean
webExtension.goForward () : Boolean
webExtension.goBackOrForward (steps:int) : Boolean // Android only
webExtension.x // setter / getter
webExtension.y // setter / getter
webExtension.width // setter / getter
webExtension.height // setter / getter
webExtension.close () : Boolean

```

Author
---------

This ANE has been writen by [I Nengah Januartha](https://github.com/janumedia). It belongs to [JanuMedia Inc.](http://www.janumedia.com) and is distributed under the [Apache Licence, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
