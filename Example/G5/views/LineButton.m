//
//  LineButton.m
//  JuHappy
//
//  Created by plusman on 15/1/27.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "LineButton.h"

@implementation LineButton

- (instancetype)initWithFrame:(CGRect)frame LineButtonType:(LineButtonType)UIButtonType; {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:USERCOLOR_DISABLED forState:UIControlStateHighlighted];
        
        self.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 10.0f, 5.0f, 10.0f);
        
        switch (UIButtonType) {
            case LineButtonBule:{
                [self setTitleColor:USERCOLOR_HTEXT forState:UIControlStateNormal];
                self.layer.borderWidth = 1;
                self.layer.cornerRadius = 5.0;
                self.layer.borderColor = USERCOLOR_HTEXT.CGColor;
                break;
            }
                
            case LineButtonYellow:{
                [self setTitleColor:USERCOLOR_ORANGE_A forState:UIControlStateNormal];
                self.layer.borderWidth = 1;
                self.layer.cornerRadius = 5.0;
                self.layer.borderColor = USERCOLOR_ORANGE_A.CGColor;
                break;
            }
                
            case LineButtonRed:{
                [self setTitleColor:USERCOLOR_REDCOLOR forState:UIControlStateNormal];
                self.layer.borderWidth = 1;
                self.layer.cornerRadius = 5.0;
                self.layer.borderColor = USERCOLOR_REDCOLOR.CGColor;
                break;
            }
        }
    }
    
    return self;
}

@end
