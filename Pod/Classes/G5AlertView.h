//
//  G5AlertView.h
//  JuHappy
//
//  Created by minug on 15/3/29.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock) (NSString *fromWhere);

@interface G5AlertView : UIAlertView

+(G5AlertView *)sharedAlertView;

// 弹框提醒不带回调事件
- (void)TTAlert:(NSString *)title message:(NSString *)message;

// 弹框提醒带回调事件
- (void)TTAlert:(NSString *)title message:(NSString *)message confirmBlock:(ConfirmBlock) block;

// 带取消
- (void)TTAlertC:(NSString *)title message:(NSString *)message confirmBlock:(ConfirmBlock) block;

// 自定义文字样式
-(void)TTAlertC:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles  confirmBlock:(ConfirmBlock) block;

@end
