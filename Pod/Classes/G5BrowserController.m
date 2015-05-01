//
//  G5BrowserController.m
//  JuHappy
//
//  Created by plusman on 14/12/23.
//  Copyright (c) 2014年 plusman. All rights reserved.
//

#import "G5BrowserController.h"
#import "G5WebView.h"

@interface G5BrowserController ()
{
    // vars
}

@property (strong,nonatomic) G5WebView *G5WebView;
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
    return [self initPrivate];
}

#pragma mark - 私有初始化函数
- (instancetype)initPrivate{
    self = [super init];
    
    if (self) {
        _G5WebView = [[G5WebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
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

#pragma mark -  网页加载
- (void)loadURL:(NSString *)url{
    G5Log(@"loadUrl: %@",url);
    _isShowNavigationBar = YES;
    [_G5WebView loadURL:url];
}


- (void)loadURLWithLocalfile:(NSString *)localFile query:(NSString *)query{
    /*测试代码*/
    _isShowNavigationBar = YES;
    [_G5WebView loadURLWithLocalfile:localFile query:@""];
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
