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
 * 发送消息通知，范围为：NSNotificationCenter defaultCenter
 */
+ (void)postNotification:(NSString *)name;
@end
