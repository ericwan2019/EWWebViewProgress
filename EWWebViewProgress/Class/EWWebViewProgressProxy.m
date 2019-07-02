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


@interface EWWebViewProgressProxy () <UIWebViewDelegate>
@property (nonatomic, weak) WKWebView *wkWebView;

@property (nonatomic, assign) float currentProgress;
@end


@implementation EWWebViewProgressProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)addWKWebViewProxy:(WKWebView *)wkWebView {
    NSAssert(wkWebView != nil, @"webView cannot be nil");
 
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    
    self.wkWebView = nil;
    if ([wkWebView isKindOfClass:[WKWebView class]]) {
        self.wkWebView = (WKWebView *)wkWebView;
        [self _wkWebViewObserver];
    }
}

- (void)dealloc {
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
        self.wkWebView = nil;
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (self.weakWebViewDelegate && [self.weakWebViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.weakWebViewDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.weakWebViewDelegate && [self.weakWebViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.weakWebViewDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (self.weakWebViewDelegate && [self.weakWebViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.weakWebViewDelegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL ret = YES;
    if (self.weakWebViewDelegate && [self.weakWebViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [self.weakWebViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return ret;
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
