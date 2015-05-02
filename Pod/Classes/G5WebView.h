//
//  G5WebView.h
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import <UIKit/UIKit.h>
#import "G5CommDefine.h"

@interface G5WebView : UIWebView


// 加载网页地址
- (void)loadURL:(NSString *)url;
- (void)loadURLWithLocalfile:(NSString *)localFile
                       query:(NSString *)query
              isInMainBundle:(BOOL)isInMainBundle;

@end
