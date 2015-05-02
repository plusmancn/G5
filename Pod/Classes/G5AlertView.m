//
//  G5AlertView.m
//  JuHappy
//
//  Created by minug on 15/3/29.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "G5AlertView.h"

@interface G5AlertView ()

@property (strong,nonatomic) ConfirmBlock cBlock;
@property (strong,nonatomic) ConfirmBlock oBlock;

@end

@implementation G5AlertView



#pragma mark - 提醒事件

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static G5AlertView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+(G5AlertView *)sharedAlertView{
    return [[self alloc] init];
}

- (void)TTAlert:(NSString *)title message:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    
    [alert show];
}

#pragma mark - 带回调事件
- (void)TTAlert:(NSString *)title message:(NSString *)message confirmBlock:(ConfirmBlock) block{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    
    _oBlock = block;
    
    [alert show];
}


#pragma mark - 带回调事件，带取消
- (void)TTAlertC:(NSString *)title message:(NSString *)message confirmBlock:(ConfirmBlock) block{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    
    _oBlock = block;
    
    [alert show];
}

-(void)TTAlertC:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles  confirmBlock:(ConfirmBlock) block{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    
    _oBlock = block;
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (_oBlock) {
        if((long)alertView.numberOfButtons == 2){
            if ((long)buttonIndex == 1) {
                _oBlock(@"okClick");
            }
        }else{
            _oBlock(@"okClick");
        }
    }
    _oBlock = nil;
}


@end
