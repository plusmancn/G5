//
//  G5UserJsSdk.h
//  G5
//
//  Created by plusman on 15/5/5.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <G5/G5JsSdk.h>
#import <G5/G5BrowserController.h>


@interface G5UserJsSdk : NSObject


/**
 * 获取单例浏览器
 */
+ (G5BrowserController *)getBrowser;

/**
 * 获取设备电量
 */
+ (float)getDeviceBatteryUsage;

@end
