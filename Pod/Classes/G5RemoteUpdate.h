//
//  G5RemoteUpdate.h
//  JuHappy
//
//  Created by plusman on 15/4/21.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^AVResultBlock)(id object,NSError *error);

@interface G5RemoteUpdate : NSObject

/**
 * 三个状态位配置
 */
@property (nonatomic,strong) NSString *updatePre;
@property (nonatomic,strong) NSString *updateing;
@property (nonatomic,strong) NSString *updateEnd;

/**
 * 远程更新缓存库
 */
+ (void)updateLocalCodeSlient:(BOOL)slient
                     showView:(UIView *)showView
                 updatePreTip:(NSString *)updatePreTip
                 updateingTip:(NSString *)updateingTip
                 updateEndTip:(NSString *)updateEndTip;




/**
 * 设置版本号
 */
+ (void)setCodeVersion:(NSInteger)version;

/**
 * 获取文件路径
 */
+(NSString*)getFilesPath:(NSString *)directory;

/**
 * 获取MainBundle文件内容
 */
+ (NSString *)loadMainBundleFile:(NSString *)pathForResource
                          ofType:(NSString *)ofType
                     inDirectory:(NSString *)inDirectory;

/**
 * 获取可写目录文件内容
 */
+ (NSString *)loadFileSystemFile:(NSString *)pathForResource
                          ofType:(NSString *)ofType
                     inDirectory:(NSString *)inDirectory;

/**
 * 配置更新时间
 */
+(void)setUpdatePadding:(NSTimeInterval)time;



@end
