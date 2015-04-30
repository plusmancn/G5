//
//  G5BrowserController.m
//  JuHappy
//
//  Created by plusman on 14/12/23.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import "G5BrowserController.h"
#import "WebViewJavascriptBridge.h" // js-bridge


@interface G5BrowserController ()  <UIWebViewDelegate>
{
    // vars
}

@property (strong,nonatomic) WebViewJavascriptBridge *bridge;
@property (strong,nonatomic) UIWebView *G5WebView;
@property (strong,nonatomic) NSMutableArray *visitedURLS;
@property (nonatomic , weak) UIView * bgView ;
@property (nonatomic , assign) CGFloat barAlpha;
@property (nonatomic , assign) BOOL isShowNavigationBar;

@end

@implementation G5BrowserController

/**
 * 浏览器单例实现，兼容两种方式初始化
 */
#pragma mark - 单例
+ (instancetype)sharedBrowser {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static G5BrowserController *sharedBrowser;
    
    static dispatch_once_t BrowserOneToken;
    
    dispatch_once(&BrowserOneToken, ^{
        sharedBrowser = [[self alloc] initPrivate];
    });
    
    return sharedBrowser;
}


#pragma mark - 私有初始化函数
- (instancetype)initPrivate{
    
    self = [super init];
    
    if (self) {
        _G5WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        // 只添加一次
        [self.view addSubview:_G5WebView];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        /* status Bar */
        UIView *statusView = [[UIView alloc] init];
        statusView.backgroundColor = RGBACOLOR(247, 247, 247, 0.9);
        statusView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
        [self.view addSubview:statusView];
        
        /**
         * 网桥初始化
         */
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:_G5WebView handler:^(id data, WVJBResponseCallback responseCallback) {

            G5Log(@"Received message from javascript: %@", data);
            responseCallback(@"Right back javascriptCore");
        }];
        
        
        
//        /**
//         * 二维码扫描接口
//         */
//        [_bridge registerHandler:@"scanQRCode" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
//            [JuJsSdk scanQrCode:self.navigationController
//                     scanResult:^(NSDictionary *resultDic) {
//                        responseCallback(@{@"errorCode":@0,
//                                           @"errorMessage":@"success",
//                                           @"data":resultDic[@"string"]
//                                           });
//            }];
//            
//        }];
//        
//        
//        /**
//         * 图像选择接口
//         */
//        [_bridge registerHandler:@"chooseImage" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
//            UIImagePickerControllerSourceType soureType = (UIImagePickerControllerSourceType)[data[@"soureType"] integerValue];
//            
//            [JuJsSdk chooseImage:self.navigationController
//                       soureType:soureType
//             returnImageData:^(NSDictionary *resultDic) {
//                 
//                 responseCallback(@{@"errorCode":@0,
//                                    @"errorMessage":@"success",
//                                    @"data":resultDic
//                                    });
//                 
//             } returnUploadProcess:^(NSInteger resultNum) {
//                 
//                 [_bridge callHandler:@"getUploadProcess"
//                                 data:[NSNumber numberWithInteger:resultNum]
//                  ];
//                 
//             } returnUploadStart:^{
//                 [_bridge callHandler:@"uploadStart"];
//             }];
//            
//            
//        }];
//        
//        /**
//         * 地理位置选取接口
//         */
//        [_bridge registerHandler:@"getLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
//            [JuJsSdk getLocation:self.navigationController result:^(NSDictionary *resultDic) {
//                responseCallback(@{@"errorCode":@0,
//                                   @"errorMessage":@"success",
//                                   @"data":resultDic
//                                   });
//            }];
//        }];
//        
//        
//        /**
//         * 地理位置展示接口
//         */
//        [_bridge registerHandler:@"openLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
//            [JuJsSdk openLocation:self.navigationController
//                             Lat:[data[@"latitude"] floatValue]
//                             lng:[data[@"longitude"] floatValue]
//                           title:data[@"address"]
//            ];
//        }];
//        
//        /**
//         * 位置签到
//         */
//        [_bridge registerHandler:@"mapMeetCheckIn" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
//            [JuJsSdk openLocation:self.navigationController
//                              Lat:[data[@"latitude"] floatValue]
//                              lng:[data[@"longitude"] floatValue]
//                            title:data[@"address"]
//                        meetingId:data[@"meetingId"]
//             ];
//            
//        }];
//        
//        /**
//         * 关闭当前窗口
//         */
//        [_bridge registerHandler:@"closeWindow" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            if (self.navigationController != nil) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                
//                [self dismissViewControllerAnimated:YES completion:^{
//                   // do something
//                }];
//            }
//            
//        }];
//        
//        /**
//         * 分享接口
//         */
//        [_bridge registerHandler:@"shareSocialNetwork" handler:^(id data, WVJBResponseCallback responseCallback) {
//            [JuJsSdk shareSocialNetwork:data];
//        }];
//        
//        /**
//         * 通知接口
//         */
//        [_bridge registerHandler:@"postNotification" handler:^(id data, WVJBResponseCallback responseCallback) {
//            [JuJsSdk postNotification:data[@"name"]];
//        }];
//        
//        
//        /**
//         * 打开好友名片
//         */
//        [_bridge registerHandler:@"openUserNameCard" handler:^(id data, WVJBResponseCallback responseCallback) {
//            [self leaveOutShowNavigation];
//            
//            [JuJsSdk openUserNameCard:self.navigationController
//                          RnameCardId:data[@"nameCardId"]
//            ];
//        }];
//        
//        
//        [_bridge registerHandler:@"openUrl" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [JuJsSdk openUrl:data[@"url"]];
//        
//        }];
        
        // 添加返回通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disabledNativeBackEffect) name:G5_Noti_diabledNativeBackEffect object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabledNativeBackEffect) name:G5_Noti_enabledNativeBackEffect object:nil];
        
        _isShowNavigationBar = YES;
        
    }
    
    return self;
}

#pragma mark - 加载事件
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    /*[self.navigationController setNavigationBarHidden:YES animated:YES];*/
    
    // 可以改变样式，不应该改变属性
    if (_isShowNavigationBar) {
        [self enabledNativeBackEffect];
    }else{
        [self disabledNativeBackEffect];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self leaveOutShowNavigation];
    [super viewWillDisappear:animated];
    
}


#pragma mark -  网页加载
// 加载网页
- (void)loadURL:(NSString *)url{
    
    G5Log(@"loadUrl: %@",url);
    
    _isShowNavigationBar = YES;
    
    NSURL *URL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [_G5WebView loadRequest:request];
}




- (void)loadURLWithLocalfile:(NSString *)localFile query:(NSString *)query{
    
    /*_isShowNavigationBar = YES;
    
    // 打印query部分
    
    NSString *header = [JuCommonFunctions loadLocalUpdateFile:@"header" ofType:@"html" inDirectory:@"www/comm/"];
    NSString *body   = [JuCommonFunctions loadLocalUpdateFile:localFile ofType:@"html" inDirectory:@"www/"];
    NSString *footer = [JuCommonFunctions loadLocalUpdateFile:@"footer" ofType:@"html" inDirectory:@"www/comm/"];
    
    NSString *html = [NSString stringWithFormat:@"%@%@%@",header,body,footer];
    
    // 添加参数
    NSURL *baseUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@.%@",[JuCommonFunctions getFilesPath:@"www/"],localFile,@"html"]];
    
    NSString *theAbsoluteURLString = [baseUrl absoluteString];
    NSString *absoluteURLwithQueryString = [theAbsoluteURLString stringByAppendingString: query];
    NSURL *finalURL = [NSURL URLWithString:absoluteURLwithQueryString];
    
    [_G5WebView loadHTMLString:html baseURL:finalURL];*/
    
    
    /*_isShowNavigationBar = YES;
     
     NSString *header = [JuCommonFunctions loadLocalFile:@"header" ofType:@"html" inDirectory:@"www/comm"];
     NSString *body   = [JuCommonFunctions loadLocalFile:localFile ofType:@"html" inDirectory:@"www"];
     NSString *footer = [JuCommonFunctions loadLocalFile:@"footer" ofType:@"html" inDirectory:@"www/comm"];
     
     NSString *html = [NSString stringWithFormat:@"%@%@%@",header,body,footer];
     
     // 添加参数
     NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:localFile ofType:@"html" inDirectory:@"www"]];
     
     
     NSString *theAbsoluteURLString = [baseUrl absoluteString];
     NSString *absoluteURLwithQueryString = [theAbsoluteURLString stringByAppendingString: query];
     NSURL *finalURL = [NSURL URLWithString:absoluteURLwithQueryString];
     
     [_G5WebView loadHTMLString:html baseURL:finalURL];*/
    
    
    /*测试代码*/
    // 添加参数
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:localFile ofType:@"html" inDirectory:@"www"]];
    
    [_G5WebView loadRequest:[[NSURLRequest alloc] initWithURL:baseUrl]];
    
}

#pragma mark - 缓存警告处理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.bgView removeFromSuperview];
    
    // webViewDidFinishLoad方法中设置如下
    [[NSUserDefaults standardUserDefaults] setInteger:0
                                               forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO
                                            forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO
                                            forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //缓存类型
    int cacheSizeMemory = 4*1024*1024;
    
    int cacheSizeDisk = 32*1024*1024;
    
    NSURLCache *sharedCache = [[NSURLCache alloc]initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    
    [NSURLCache setSharedURLCache:sharedCache];
    
}

#pragma mark - 缓存警告处理
- (void)didReceiveMemoryWarning {

    G5Log(@"Respnose to memory warning");
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super didReceiveMemoryWarning];
}

#pragma mark - 清楚所有浏览器缓存
- (void)removeAllCachedResponses{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark  - 浏览器返回事件处理
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回边界系列函数方法
- (void)disabledNativeBackEffect{
    _isShowNavigationBar = NO;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)enabledNativeBackEffect{
    
    _isShowNavigationBar = YES;
    [self.navigationController setNavigationBarHidden:NO];
    _barAlpha =  self.navigationController.navigationBar.alpha;
    self.navigationController.navigationBar.alpha = 0.0;
    
}

- (void)leaveOutShowNavigation{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.alpha = 1.0;
}

@end
