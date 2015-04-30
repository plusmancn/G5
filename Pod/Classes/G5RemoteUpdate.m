//
//  G5RemoteUpdate.m
//  JuHappy
//
//  Created by plusman on 15/4/21.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "G5RemoteUpdate.h"

// 动态菊花
#import "MBProgressHUD+XBX.h"
#import <MBProgressHUD/MBProgressHUD.h>

// 资源更新
#import <AFNetworking/AFNetworking.h>
#import <ZipArchive/ZipArchive.h>

@implementation G5RemoteUpdate

// 触发器
+ (void)updateLocalCode:(BOOL)slient showView:(UIView *)showView{

    if ([self getCodeVersion] == 0) {
        [self installCode:1];
    }else{
        
        /*NSDictionary *params = @{
                                 @"platform":@"ios"
                                 };
        
        // 获取远程下载地址
        [AVCloud callFunctionInBackground:@"verLatest" withParameters:params block:^(id object, NSError *error) {
            
            if (error) {
                return;
            }
            
            if([self getCodeVersion] - [object[@"data"][@"version"] longValue] < 0){
                
                NSString *message = [NSString stringWithFormat:@"大小:%@，是否立即下载？",object[@"data"][@"zipSize"]];
                
                
                if([object[@"data"][@"isForceUpdate"] intValue] == 0){
                    
                    [[JuAlertView sharedAlertView] TTAlertC:@"会议数据有更新" message:message cancelButtonTitle:@"取消" otherButtonTitles:@"下载" confirmBlock:^(NSString *fromWhere) {
                        
                        [self setCodeVersion:[object[@"data"][@"version"] longValue]];
                        [self updateLocalCodeAction:object[@"data"][@"zipUrl"] showView:showView];
                        
                    }];
                    
                }else{
                    
                    [self setCodeVersion:[object[@"data"][@"version"] longValue]];
                    [self updateLocalCodeAction:object[@"data"][@"zipUrl"] showView:showView];
                    
                }
                
            }else{
                if (!slient) {
                    NSString *message = [NSString stringWithFormat:@"当前数据版本: %ld",(long)[self getCodeVersion]];
                    [[JuAlertView sharedAlertView] TTAlert:@"已经是最新版啦" message:message];
                }
            }
        }];*/
        
    }
}


// 更新代码库
+ (void)updateLocalCodeAction:(NSString *)zipUrl showView:(UIView *)showView{
    
    // 展现登录菊花
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:13];
    HUD.labelText = @"拉取会议数据中....";
    
    // 下载前清空远程目录
    [self deleteOldFolder:@"remotePub"];
    
    // 下载远程www代码包
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:zipUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@",[self getFilesPath:@"remotePub/"],[response suggestedFilename]]];
        
        return documentsDirectoryURL;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        // 解压缩操作
        NSString *zipPath = [[self getFilesPath:@"remotePub/"] stringByAppendingString:[filePath lastPathComponent]];
        
        NSString *destinationPath = [self getFilesPath:@""];
        
        // 删除旧文件夹
        [self deleteOldFolder:@"www"];
        
        ZipArchive *zip = [[ZipArchive alloc] init];
        
        if ([zip UnzipOpenFile:zipPath]) {
            [zip UnzipFileTo:destinationPath overWrite:YES];
            [zip UnzipCloseFile];
        }else{
            // to do something
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:showView animated:YES];
            [MBProgressHUD showSuccessWithView:showView Text:@"会议数据更新成功" hideDelayTime:1.0];
        });
        
    }];
    
    [downloadTask resume];
}


// 本地安装包
+ (void)installCode:(NSInteger)version{
    [self deleteOldFolder:@"www"];
    [self deleteOldFolder:@"remotePub"];
    
    NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"www" ofType:@"zip"];
    
    NSString *destinationPath = [[self getFilesPath:@"remotePub/"] stringByAppendingString:@"www.zip"];
    
    [[NSFileManager defaultManager] copyItemAtPath:zipPath toPath:destinationPath error:nil];
    
    // 安装Code
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    if ([zip UnzipOpenFile:destinationPath]) {
        [zip UnzipFileTo:[self getFilesPath:@""] overWrite:YES];
        [zip UnzipCloseFile];
        
        [self setCodeVersion:version];
    }else{
        // to do something
        NSLog(@"ope fail");
    }
}


+ (void)deleteOldFolder:(NSString *)folder{
    // 删除www文件夹
    NSString *delPath = [self getFilesPath:folder];
    [[NSFileManager defaultManager] removeItemAtPath:delPath error:nil];
}


// 获取文件版本
+ (NSInteger)getCodeVersion{
    
    NSInteger version = [[NSUserDefaults standardUserDefaults] integerForKey:@"htmlCodeVersion"];
    
    if (!version) {
        return 0;
    }

    return version;
}

// 设置版本号
+ (void)setCodeVersion:(NSInteger)version{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:version] forKey:@"htmlCodeVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// 获取临时文件存放路径
+(NSString*)getFilesPath:(NSString *)directory{
    
    NSString* appPath=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* filesPath=[appPath stringByAppendingString:[NSString stringWithFormat:@"/%@",directory]];
    NSFileManager *fileMan=[NSFileManager defaultManager];
    NSError *error;
    BOOL isDir=YES;
    if([fileMan fileExistsAtPath:filesPath isDirectory:&isDir]==NO){
        [fileMan createDirectoryAtPath:filesPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error){
            [NSException raise:@"error when create dir" format:@"error"];
        }
    }
    return filesPath;
}

#warning 网络检测，据说 会被 app store 拒绝，首个版本发布后，在考虑添加

@end
