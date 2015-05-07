//
//  G5BrowserController.h
//  JuHappy
//
//  Created by plusman on 14/12/23.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G5CommDefine.h"
#import "G5WebView.h"

#define  G5AppActive [[NSNotificationCenter defaultCenter] postNotificationName:@"G5ApplicationDidBecomeActive" object:nil];

// 判读是否已经初始化过

@interface G5BrowserController : UIViewController <UIWebViewDelegate>

/**
 * 暴露浏览器内核
 */
@property (strong,nonatomic) G5WebView *G5WebView;

/**
 * 加载网页地址
 */
- (void)loadURL:(NSString *)url;
- (void)loadURLWithLocalfile:(NSString *)localFile
                       query:(NSString *)query
              isInMainBundle:(BOOL)isInMainBundle;

/**
 * 导航栏挂起
 */
- (void)leaveOutShowNavigation;

@end
