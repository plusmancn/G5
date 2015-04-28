//
//  CommonDefine.h
//  G5
//
//  Created by plusman on 15/4/28.
//  Copyright (c) 2015年 plusmancn. All rights reserved.
//

#ifndef G5_CommonDefine_h
#define G5_CommonDefine_h

/**
 * 弹框提醒
 */
#import <TAlertView/TAlertView.h>

/**
 * 引入masony自动布局
 */
#import <QuartzCore/QuartzCore.h>
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>


/**
 * 引入 G5
 */


/**
 * 自定义颜色生成函数
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed:((rgb) & 0xFF0000 >> 16)/255.0 green:((rgb) & 0xFF00 >> 8)/255.0 blue:((rgb) & 0xFF)/255.0 alpha:1.0]


// 定义颜色
#define USERCOLOR_HTEXT RGBCOLOR(60,130,250)
#define USERCOLOR_NAME RGBCOLOR(50,100,200)
#define USERCOLOR_DISABLED RGBACOLOR(230,230,230,0.8)
#define USERCOLOR_BACKGROUND RGBCOLOR(245,245,245)
#define USERCOLOR_REDCOLOR RGBCOLOR(240,85,85)
#define USERCOLOR_ORANGE_A RGBACOLOR(250,130,60,0.8)
#define USERCOLOR_GRAY_BLANK RGBACOLOR(207,207,207,1)


/**
 * 自定义log输出，DEBUG 为系统变量
 */
#ifdef DEBUG
#define JuLog(...) NSLog(__VA_ARGS__)
#else
#define JuLog(...)
#endif


#endif
