//
//  G5BrowserController.m
//  JuHappy
//
//  Created by plusman on 14/12/23.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import "G5BrowserController.h"

@interface G5BrowserController ()
{
    // vars
}
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
    static G5BrowserController *sharedBrowser;
    static dispatch_once_t BrowserOneToken;
    
    dispatch_once(&BrowserOneToken, ^{
        sharedBrowser = [[self alloc] initPrivate];
    });
    
    return sharedBrowser;
}

- (instancetype)init{
    return [G5BrowserController sharedBrowser];
}

#pragma mark - 私有初始化函数
- (instancetype)initPrivate{
    self = [super init];
    
    if (self) {
        _G5WebView = [[G5WebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        /**
         * 关闭当前窗口
         */
        [_G5WebView.bridge registerHandler:@"closeWindow" handler:^(id data, WVJBResponseCallback responseCallback) {
            
            if (self.navigationController != nil) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self dismissViewControllerAnimated:YES completion:^{
                    // do something
                }];
            }
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:@"G5ApplicationDidBecomeActive" object:nil];
        
        [self.view addSubview:_G5WebView];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
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

-(void)applicationDidBecomeActive:(NSNotification*)note{
    if (self.navigationController) {
        self.navigationController.navigationBar.alpha = 0.0;
    }
}

#pragma mark -  网页加载
- (void)loadURL:(NSString *)url{
    G5Log(@"loadUrl: %@",url);
    _isShowNavigationBar = YES;
    [_G5WebView loadURL:url];
}


- (void)loadURLWithLocalfile:(NSString *)localFile
                       query:(NSString *)query
              isInMainBundle:(BOOL)isInMainBundle{
    /*测试代码*/
    _isShowNavigationBar = YES;
    [_G5WebView loadURLWithLocalfile:localFile query:query isInMainBundle:isInMainBundle];
}


#pragma mark - 返回边界系列函数方法
- (void)disabledNativeBackEffect{
    self.isShowNavigationBar = NO;
    
}


- (void)enabledNativeBackEffect{
    self.isShowNavigationBar = YES;
}

- (void)leaveOutShowNavigation{
    self.isShowNavigationBar = YES;
    //    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.alpha = 1.0;
}


-(void)setIsShowNavigationBar:(BOOL)isShowNavigationBar{
    _isShowNavigationBar = isShowNavigationBar;
    
    if (_isShowNavigationBar) {
        [self.navigationController setNavigationBarHidden:NO];
        _barAlpha =  self.navigationController.navigationBar.alpha;
        self.navigationController.navigationBar.alpha = 0.0;
    }else{
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}


@end
