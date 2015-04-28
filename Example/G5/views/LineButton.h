//
//  LineButton.h
//  JuHappy
//
//  Created by plusman on 15/1/27.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"

typedef enum {
    LineButtonBule,
    LineButtonYellow,
    LineButtonRed
}LineButtonType;

@interface LineButton : UIButton


- (instancetype)initWithFrame:(CGRect)frame LineButtonType:(LineButtonType)UIButtonType;

@end
