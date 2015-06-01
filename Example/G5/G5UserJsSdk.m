//
//  G5UserJsSdk.m
//  G5
//
//  Created by plusman on 15/5/5.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#import "G5UserJsSdk.h"

@implementation G5UserJsSdk


+ (G5BrowserController *)getBrowser{
    G5BrowserController *brower = [[G5BrowserController alloc] init];
    
    static dispatch_once_t eventBrowserOneToken;
    dispatch_once(&eventBrowserOneToken, ^{
        [self bindJsEvents:brower];
    });
    
    return brower;
}


+ (void)bindJsEvents:(G5BrowserController *)browser{
    /**
     * 二维码扫描接口
     */
    [browser.G5WebView.bridge registerHandler:@"getDeviceBatteryUsage" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@{@"errorCode":@0,
                             @"errorMessage":@"success",
                             @"data":[NSNumber numberWithFloat:[self getDeviceBatteryUsage]]
                        });
    }];
    
    
}



+(float)getDeviceBatteryUsage{
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    UIDevice *myDevice = [UIDevice currentDevice];
    
    [myDevice setBatteryMonitoringEnabled:YES];
    float batLeft = (float)[myDevice batteryLevel];
    
    return batLeft;
}

@end
