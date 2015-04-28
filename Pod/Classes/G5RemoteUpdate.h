//
//  G5RemoteUpdate.h
//  JuHappy
//
//  Created by plusman on 15/4/21.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface G5RemoteUpdate : NSObject

// 远程更新代码库
+ (void)updateLocalCode:(BOOL)slient showView:(UIView *)showView;

// 安装代码库
+ (void)installCode:(NSInteger)version;



@end
