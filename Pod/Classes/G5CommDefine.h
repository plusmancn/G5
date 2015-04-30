//
//  G5CommDefine.h
//  Pods
//
//  Created by plusman on 15/4/28.
//
//

#ifndef Pods_G5CommDefine_h
#define Pods_G5CommDefine_h

/** 
 *
 */
#define G5_Noti_diabledNativeBackEffect @"G5_Noti_diabledNativeBackEffect" // 禁用浏览器原生滑动返回
#define G5_Noti_enabledNativeBackEffect @"G5_Noti_enabledNativeBackEffect"


/**
 * 定义屏幕高度和宽度
 */
#define NAVIGATION_HEIGHT 64
#define TABBAR_HEIGHT 44
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


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
#define G5Log(...) NSLog(__VA_ARGS__)
#else
#define G5Log(...)
#endif

#endif
