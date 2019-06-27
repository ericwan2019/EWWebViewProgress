//
//  EWWebViewProgressProxy.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/25.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "EWWebViewProgressProxy.h"


float const EWWebViewProgressProxyInitialValue = 0.1;
float const EWWebViewProgressProxyFinalValue = 0.85;
float const EWWebViewProgressProxyInteractiveValue = 0.5;


@interface EWWebViewProgressProxy () <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, weak) WKWebView *wkWebView;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, weak) UIWebView *webView;
#pragma clang diagnostic pop
@property (nonatomic, assign) float currentProgress;
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSAssert(![webView isKindOfClass:[WKWebView class]] || ![webView isKindOfClass:[UIWebView class]], @"webView must be UIWebView or WKWebView");
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    
    self.wkWebView = nil;
    self.webView = nil;
    if ([webView isKindOfClass:[WKWebView class]]) {
        self.wkWebView = (WKWebView *)webView;
        [self _wkWebViewObserver];
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
        self.currentProgress = progress;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - WKWebView Private
- (void)_wkWebViewObserver {
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
}

//UIWebView开始进度
- (void)_startProgress {
    if (self.progress < EWWebViewProgressProxyInitialValue) {
        self.currentProgress = EWWebViewProgressProxyInitialValue;
    }
}

//UIWebView完成进度
- (void)_completedProgress {
    self.currentProgress = 1.0;
}


#pragma mark - Set & get
- (float)progress {
    return self.currentProgress;
}

- (void)setCurrentProgress:(float)currentProgress {
    _currentProgress = currentProgress;
    if (self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(webViewProgressProxy:progress:)]) {
        [self.progressDelegate webViewProgressProxy:self progress:currentProgress];
    }
    if (self.progressProxyBlock) {
        self.progressProxyBlock(currentProgress);
    }
}

@end
