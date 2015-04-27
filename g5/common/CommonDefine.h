//
//  CommonDefine.h
//  g5
//
//  Created by plusman on 15/4/27.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#ifndef g5_CommonDefine_h
#define g5_CommonDefine_h

/**
 * 引入masony自动布局
 */
#import <QuartzCore/QuartzCore.h>
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

/**
 * 自定义颜色生成函数
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed:((rgb) & 0xFF0000 >> 16)/255.0 green:((rgb) & 0xFF00 >> 8)/255.0 blue:((rgb) & 0xFF)/255.0 alpha:1.0]


/**
 * 自定义log输出，DEBUG 为系统变量
 */
#ifdef DEBUG
    #define JuLog(...) NSLog(__VA_ARGS__)
#else
    #define JuLog(...)
#endif


#endif
