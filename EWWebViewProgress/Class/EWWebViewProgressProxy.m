//
//  EWWebViewProgressProxy.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/25.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "EWWebViewProgressProxy.h"

@interface EWWebViewProgressProxy () <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UIWebView *webView;
#pragma clang diagnostic pop

@end


@implementation EWWebViewProgressProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)setProxyWebView:(id)webView {
    NSAssert(webView == nil, @"webView cannot be nil");
    self.wkWebView = nil;
    self.webView = nil;
    if ([webView isKindOfClass:[WKWebView class]]) {
        self.wkWebView = (WKWebView *)webView;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    } else if ([webView isKindOfClass:[UIWebView class]]) {
        self.webView = (UIWebView *)webView;
    }
#pragma clang diagnostic pop
    
    
    
}


@end
