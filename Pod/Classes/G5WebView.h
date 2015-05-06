//
//  G5WebView.h
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import <UIKit/UIKit.h>
#import "G5CommDefine.h"
#import "WebViewJavascriptBridge.h" // Js-Bridge

@interface G5WebView : UIWebView

/**
 * 网桥接口，可向内部注册 js 方法
 */
@property (strong,nonatomic) WebViewJavascriptBridge *bridge;


/**
 * 加载网页地址
 */
- (void)loadURL:(NSString *)url;
- (void)loadURLWithLocalfile:(NSString *)localFile
                       query:(NSString *)query
              isInMainBundle:(BOOL)isInMainBundle;

@end
