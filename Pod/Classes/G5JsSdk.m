//
//  G5JsSdk.m
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import "G5JsSdk.h"

@implementation G5JsSdk


+ (void)postNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

@end
