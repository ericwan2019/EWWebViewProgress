//
//  EWWebViewProgressProxy.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/25.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "EWWebViewProgressProxy.h"

@interface EWWebViewProgressProxy () <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, weak) WKWebView *wkWebView;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, weak) UIWebView *webView;
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
    NSAssert(webView != nil, @"webView cannot be nil");
    NSAssert(![webView isKindOfClass:[WKWebView class]] || ![webView isKindOfClass:[UIWebView class]], @"webView must be UIWebView or WKWebView");
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    
    self.wkWebView = nil;
    self.webView = nil;
    if ([webView isKindOfClass:[WKWebView class]]) {
        self.wkWebView = (WKWebView *)webView;
        [self _wkWebViewObserver];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    } else if ([webView isKindOfClass:[UIWebView class]]) {
        self.webView = (UIWebView *)webView;
    }
#pragma clang diagnostic pop
}

- (void)dealloc {
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
        self.wkWebView = nil;
    }
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.wkWebView) {
        float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        if (self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(webViewProgressProxy:progress:)]) {
            [self.progressDelegate webViewProgressProxy:self progress:progress];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - WKWebView Private
- (void)_wkWebViewObserver {
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
}

@end
