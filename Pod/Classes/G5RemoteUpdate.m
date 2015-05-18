//
//  G5RemoteUpdate.m
//  JuHappy
//
//  Created by plusman on 15/4/21.
//  Copyright (c) 2015年 plusman. All rights reserved.
//

#import "G5RemoteUpdate.h"
#import "G5CommDefine.h"
#import "G5AlertView.h"

// 动态菊花
#import "MBProgressHUD+G5.h"
#import <MBProgressHUD/MBProgressHUD.h>

// 资源更新
#import <AFNetworking/AFNetworking.h>
#import <ZipArchive/ZipArchive.h>

@implementation G5RemoteUpdate


static NSDate *latestUpdate;
static NSTimeInterval updateTime;


+(void)initialize{
    [super initialize ];
    latestUpdate = [NSDate date];
    updateTime = 10 * 60;
}

// 触发器
+ (void)updateLocalCodeSlient:(BOOL)slient
                     showView:(UIView *)showView
                 updatePreTip:(NSString *)updatePreTip
                 updateingTip:(NSString *)updateingTip
                 updateEndTip:(NSString *)updateEndTip{
    if (([[NSDate date] timeIntervalSinceDate:latestUpdate] <= updateTime)) {
        return;
    }
    
    G5Log(@"开始进入程序更新流程");
    //保存最新一次的查询时间
    latestUpdate = [NSDate date];
    
    NSDictionary *params = @{
                             @"platform":@"ios",
                             @"appid":@"appid_hyx"
                             };
    
    // 展现登录菊花
    /*MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:showView animated:YES];
     HUD.labelFont = [UIFont systemFontOfSize:13];
     HUD.labelText = @"连接网络中...";*/
    
    [G5RemoteUpdate callCloudFunc:@"verLatest" params:params block:^(id object, NSError *error) {
        /*dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:showView animated:YES];
        });*/
        if (error) {
            /*[[G5AlertView sharedAlertView] TTAlert:@"网络连接错误" message:@"请检查你的网络设置"];*/
            return;
        }
        
        if ([object[@"errorCode"] intValue] != 0) {
            [[G5AlertView sharedAlertView] TTAlert:@"报错啦！" message:object[@"errorMessage"]];
        }else if([self getCodeVersion] - [object[@"data"][@"version"] longValue] < 0 ){
            NSString *message = [NSString stringWithFormat:@"大小:%@，是否立即下载？",object[@"data"][@"zipSize"]];
            
            if([object[@"data"][@"isForceUpdate"] intValue] == 0){
                
                [[G5AlertView sharedAlertView] TTAlertC:updatePreTip message:message cancelButtonTitle:@"取消" otherButtonTitles:@"更新" confirmBlock:^(NSString *fromWhere) {
                    
                    [self setCodeVersion:[object[@"data"][@"version"] longValue]];
                    [self updateLocalCodeAction:object[@"data"][@"zipUrl"]
                                       showView:showView
                                   updateingTip:updateingTip
                                   updateEndTip:updateEndTip
                     ];
                }];
                
            }else{
                [self setCodeVersion:[object[@"data"][@"version"] longValue]];
                [self updateLocalCodeAction:object[@"data"][@"zipUrl"]
                                   showView:showView
                               updateingTip:updateingTip
                               updateEndTip:updateEndTip
                 ];
            }
            
        }else{
            G5Log(@"已经是最新版本啦");
        }
    }];
    
}


// 更新代码库
+ (void)updateLocalCodeAction:(NSString *)zipUrl
                     showView:(UIView *)showView
                 updateingTip:(NSString *)updateingTip
                 updateEndTip:(NSString *)updateEndTip{
    // 下载前清空远程目录
    [self deleteOldFolder:@"remotePub"];
    
    // 进度条
    __block MBProgressHUD *hudBarLine;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         hudBarLine = [MBProgressHUD showBarLineProcess:showView labelText:updateingTip];
    }];
    
    // 下载远程www代码包
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:zipUrl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSString *path = [NSString stringWithFormat:@"%@%@",[self getFilesPath:@"remotePub/"],@"wwwZip.zip"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        G5Log(@"Successfully downloaded file to %@", path);
        
        // 解压缩操作
        NSString *zipPath = path;
        NSString *destinationPath = [self getFilesPath:@""];
        
        // 删除旧文件夹
        [self deleteOldFolder:@"www"];
        
        ZipArchive *zip = [[ZipArchive alloc] init];
        
        if ([zip UnzipOpenFile:zipPath]) {
            [zip UnzipFileTo:destinationPath overWrite:YES];
            [zip UnzipCloseFile];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:showView animated:YES];
                [MBProgressHUD showSuccessWithView:showView Text:updateEndTip hideDelayTime:2.0];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:showView animated:YES];
                [MBProgressHUD showFailWithView:showView Text:@"报错啦！" hideDelayTime:2.0];
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        G5Log(@"%@",error);
    }];
    
    [operation start];
    
    
    // 进度条
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
        G5Log(@"%f",progress);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            hudBarLine.progress = progress;
        }];
    }];
}


/**
 * 本地安装代码库
 * 禁用：app store 不允许在用户未操作的情况下，向用户目录写数据
 */
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

/**
 * 设置版本号
 */
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

// 本地文件加载
+ (NSString *)loadMainBundleFile:(NSString *)pathForResource
                          ofType:(NSString *)ofType
                     inDirectory:(NSString *)inDirectory{
    NSString *htmlFileBody = [[NSBundle mainBundle] pathForResource:pathForResource ofType:ofType inDirectory:inDirectory];
    
    NSString *htmlStringBody = [NSString stringWithContentsOfFile:htmlFileBody encoding:NSUTF8StringEncoding error:nil];
    
    return htmlStringBody;
}

/**
 * 加载实时更新文件
 */
+ (NSString *)loadFileSystemFile:(NSString *)pathForResource
                          ofType:(NSString *)ofType
                     inDirectory:(NSString *)inDirectory{
    
    NSString *path = [self getFilesPath:inDirectory];
    
    NSString *htmlFileBody = [NSString stringWithFormat:@"%@%@.%@",path,pathForResource,ofType];
    
    NSString *htmlStringBody = [NSString stringWithContentsOfFile:htmlFileBody encoding:NSUTF8StringEncoding error:nil];
    
    return htmlStringBody;
}

/**
 * LeanCloud云函数调用
 */
+ (void)callCloudFunc:(NSString *)func
               params:(NSDictionary *)params
                block:(AVResultBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *lastParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [lastParams setObject:func forKey:@"func"];
    
    [manager POST:@"http://g5-server.avosapps.com/callCloudFunc"
       parameters:lastParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               block(responseObject,nil);
           }];
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               block(nil,error);
           }];
       }];
    
}

+(void)setUpdatePadding:(NSTimeInterval)time{
    updateTime = time;
}

@end
