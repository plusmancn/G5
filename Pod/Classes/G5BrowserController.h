//
//  G5BrowserController.h
//  JuHappy
//
//  Created by plusman on 14/12/23.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G5CommDefine.h"

@interface G5BrowserController : UIViewController <UIWebViewDelegate>

// 加载网页地址
- (void)loadURL:(NSString *)url;
- (void)loadURLWithLocalfile:(NSString *)localFile query:(NSString *)query;


// 单实例化
+ (instancetype)sharedBrowser;


@end
