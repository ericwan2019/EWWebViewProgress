//
//  ViewController.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/16.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "ViewController.h"
#import "EWWebViewProgressView.h"
#import "EWWebViewProgressProxy.h"
#import <WebKit/WebKit.h>

@interface ViewController () <EWWebViewProgressDelegate, WKNavigationDelegate>
@property (nonatomic, strong) EWWebViewProgressView *progressView;
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) EWWebViewProgressProxy *webViewProxy;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    self.webViewProxy = [[EWWebViewProgressProxy alloc] init];
    [self.webViewProxy setProxyWebView:self.webView];
    self.webViewProxy.progressDelegate = self;
 
    self.progressView = [[EWWebViewProgressView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 2)];
    [self.view addSubview:self.progressView];
}



#pragma mark - EWWebViewProgressDelegate
- (void)webViewProgressProxy:(EWWebViewProgressProxy *)webViewProgressProxy progress:(float)progress {
    NSLog(@"progress = %f",progress);
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
        //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
        //不允许跳转
        //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
        //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
        //不允许跳转
        //decisionHandler(WKNavigationActionPolicyCancel);
}

@end
