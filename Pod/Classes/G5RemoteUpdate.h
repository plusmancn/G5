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
 * 远程更新代码库
 */
+ (void)updateLocalCodeSlient:(BOOL)slient showView:(UIView *)showView;

/**
 * 安装代码库
 */
+ (void)installCode:(NSInteger)version;

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

@end
