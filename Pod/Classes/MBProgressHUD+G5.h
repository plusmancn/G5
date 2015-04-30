//
//  MBProgressHUD+G5.h
//  HXD
//
//  Created by minug on 15/4/2.
//  Copyright (c) 2015年 minug. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (G5)

+(void)showWithView:(UIView *)view Text:(NSString *)text hideDelayTime:(NSTimeInterval )time;
+(void)showSuccessWithView:(UIView *)view Text:(NSString *)text hideDelayTime:(NSTimeInterval )time;
+(void)showFailWithView:(UIView *)view Text:(NSString *)text hideDelayTime:(NSTimeInterval )time;

@end
