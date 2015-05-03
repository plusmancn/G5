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
 * push方式，浏览器滑动返回
 */
#define G5_Noti_diabledNativeBackEffect @"G5_Noti_diabledNativeBackEffect"
#define G5_Noti_enabledNativeBackEffect @"G5_Noti_enabledNativeBackEffect"

/*
 *  System Versioning Preprocessor Macros
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


/**
 * 定义屏幕高度和宽度
 */
#define NAVIGATION_HEIGHT 64
#define TABBAR_HEIGHT 44
#define STATUSBAR_HEIGHT 20
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


/**
 * 自定义颜色生成函数
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed:((rgb) & 0xFF0000 >> 16)/255.0 green:((rgb) & 0xFF00 >> 8)/255.0 blue:((rgb) & 0xFF)/255.0 alpha:1.0]


/**
 * G5 resourceBundle
 */
#define G5_BUNDLE [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"G5" ofType:@"bundle"]]
#define G5_BUNDLE_FUNC(fileName) [NSString stringWithFormat:@"G5.bundle/%@",fileName]

/**
 * 自定义log输出，DEBUG 为系统变量
 */
#ifdef DEBUG
#define G5Log(...) NSLog(__VA_ARGS__)
#else
#define G5Log(...)
#endif

#endif
