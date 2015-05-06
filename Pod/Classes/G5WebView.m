//
//  G5WebView.m
//  Pods
//
//  Created by plusman on 15/4/30.
//
//

#import "G5WebView.h"
#import "G5JsSdk.h"
#import "G5RemoteUpdate.h"

@interface G5WebView()<UIWebViewDelegate>

@property (nonatomic, weak) id<UIWebViewDelegate> privateDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate> rawDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate> outDelegate;

// 内部变量
@property (nonatomic ,strong) NSString *html;
@property (nonatomic ,strong) NSURL *baseUrl;

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
    self.backgroundColor = RGBCOLOR(247, 247, 248);
    
    // 更改status bar 背景色
    UIView *statusView = [[UIView alloc] init];
    statusView.backgroundColor = RGBACOLOR(247, 247, 248, 0.9);
    statusView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    [self addSubview:statusView];
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
- (void)loadURLWithLocalfile:(NSString *)localFile
                       query:(NSString *)query
              isInMainBundle:(BOOL)isInMainBundle{
    
    
    if (isInMainBundle) {
        NSString *header = [G5RemoteUpdate loadMainBundleFile:@"header" ofType:@"html" inDirectory:@"www/comm/"];
        NSString *body   = [G5RemoteUpdate loadMainBundleFile:localFile ofType:@"html" inDirectory:@"www/"];
        NSString *footer = [G5RemoteUpdate loadMainBundleFile:@"footer" ofType:@"html" inDirectory:@"www/comm/"];
        
        _html = [NSString stringWithFormat:@"%@%@%@",header,body,footer];
        
        NSString *baseUrlString = [[NSBundle mainBundle] pathForResource:localFile ofType:@"html" inDirectory:@"www/"];
        
        _baseUrl = [NSURL fileURLWithPath:baseUrlString];
        
        
    }else{
        
        NSString *header = [G5RemoteUpdate loadFileSystemFile:@"header" ofType:@"html" inDirectory:@"www/comm/"];
        NSString *body   = [G5RemoteUpdate loadFileSystemFile:localFile ofType:@"html" inDirectory:@"www/"];
        NSString *footer = [G5RemoteUpdate loadFileSystemFile:@"footer" ofType:@"html" inDirectory:@"www/comm/"];
        
        _html = [NSString stringWithFormat:@"%@%@%@",header,body,footer];
        
        _baseUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@.%@",[G5RemoteUpdate getFilesPath:@"www/"],localFile,@"html"]];
    }
    
    
     
    NSString *theAbsoluteURLString = [_baseUrl absoluteString];
    NSString *absoluteURLwithQueryString = [theAbsoluteURLString stringByAppendingString:query];
    NSURL *finalURL = [NSURL URLWithString:absoluteURLwithQueryString];
    
    [self loadHTMLString:_html baseURL:finalURL];
}


#pragma mark - 缓存警告处理，需要设置浏览器代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.privateDelegate webViewDidFinishLoad:webView];
    }
    
    if (self.rawDelegate && [self.rawDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.rawDelegate webViewDidFinishLoad:webView];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    if (self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.privateDelegate webViewDidStartLoad:webView];
    }
    
    if (self.rawDelegate && [self.rawDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.rawDelegate webViewDidStartLoad:webView];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.privateDelegate webView:webView didFailLoadWithError:error];
    }
    
    if (self.rawDelegate && [self.rawDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.rawDelegate webView:webView didFailLoadWithError:error];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
       return [self.privateDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    if (self.rawDelegate && [self.rawDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.rawDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}



-(void)setDelegate:(id<UIWebViewDelegate>)delegate{
    
    if (delegate == self) {
        [super setDelegate:delegate];
    }else if([delegate isKindOfClass:[WebViewJavascriptBridge class]]){
        _rawDelegate = delegate;
    }else{
        _privateDelegate = delegate;
    }
    
}


@end
