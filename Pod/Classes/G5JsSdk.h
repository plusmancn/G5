//
//  G5JsSdk.h
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import <Foundation/Foundation.h>

@interface G5JsSdk : NSObject


/**
 * 在系统自带浏览器内打开链接
 */
+ (void)openUrl:(NSString *)url;

/**
 * 发送消息通知，范围为：NSNotificationCenter defaultCenter
 */
+ (void)postNotification:(NSString *)name;
@end
