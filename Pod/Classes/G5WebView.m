//
//  G5WebView.m
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import "G5WebView.h"
#import "WebViewJavascriptBridge.h" // Js-Bridge
#import "G5JsSdk.h"

@interface G5WebView()<UIWebViewDelegate>

@property (weak,nonatomic) id<UIWebViewDelegate> delageteJs;
@property (weak,nonatomic) id<UIWebViewDelegate> delagateOut;
@property (strong,nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation G5WebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initOptions];
        [self initBridgeEvent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initOptions];
        [self initBridgeEvent];
    }
    return self;
}



- (void)initOptions{
    self.scrollView.bounces = NO; // 防止网页头尾被拖动
}

#pragma mark - 初始化网桥实现
- (void)initBridgeEvent{
    self.delegate = self;
    /**
     * 网桥初始化
     */
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self handler:^(id data, WVJBResponseCallback responseCallback) {
        G5Log(@"Received message from javascript: %@", data);
        responseCallback(@"Right back javascriptCore");
    }];
    
    /**
     * 消息通知接口
     */
    [_bridge registerHandler:@"postNotification" handler:^(id data, WVJBResponseCallback responseCallback) {
        [G5JsSdk postNotification:data[@"name"]];
    }];
}

#pragma mark -  网页加载
- (void)loadURL:(NSString *)url{
    G5Log(@"loadUrl: %@",url);
    NSURL *URL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [self loadRequest:request];
}


#pragma mark - 加载本地文件
- (void)loadURLWithLocalfile:(NSString *)localFile query:(NSString *)query{
    
    /*_isShowNavigationBar = YES;
    
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
    
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:localFile ofType:@"html" inDirectory:@"www"]];
    [self loadRequest:[[NSURLRequest alloc] initWithURL:baseUrl]];
    
}


#pragma mark - 缓存警告处理，需要设置浏览器代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
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

// 代理方法
- (void)setDelegate:(id<UIWebViewDelegate>)delegate{
    [super setDelegate:delegate];
}


@end
