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

@property (nonatomic, weak) id<UIWebViewDelegate> privateDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate> outDelegate;

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
    
    if ([self.privateDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.privateDelegate webViewDidFinishLoad:webView];
    }
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

-(void)webViewDidStartLoad:(UIWebView *)webView{
    if ([self.privateDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.privateDelegate webViewDidStartLoad:webView];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([self.privateDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.privateDelegate webView:webView didFailLoadWithError:error];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([self.privateDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
       return [self.privateDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}


-(void)setDelegate:(id<UIWebViewDelegate>)delegate{
    if (delegate == self) {
        [super setDelegate:delegate];
    }else{
        _privateDelegate = delegate;
    }
}


@end
