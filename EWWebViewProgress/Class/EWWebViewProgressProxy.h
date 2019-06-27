//
//  EWWebViewProgressProxy.h
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/25.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EWWebViewProgressProxy;
@protocol EWWebViewProgressDelegate <NSObject>

@optional
- (void)webViewProgressProxy:(EWWebViewProgressProxy *)webViewProgressProxy progress:(float)progress;

@end

typedef void(^EWWebViewProgressProxyBlock)(float progress);

@interface EWWebViewProgressProxy : NSObject

//progress delegate
@property (nonatomic, weak) id<EWWebViewProgressDelegate>progressDelegate;

//current prigress
@property (nonatomic, assign, readonly) float progress;

//progress block. if you dont wanna use delegate, you can use this block
@property (nonatomic, copy) EWWebViewProgressProxyBlock progressProxyBlock;
/**
 set proxy webview（wkwebview / uiwebview)

 @param webView proxy webview
 */
- (void)setProxyWebView:(id)webView;

@end

NS_ASSUME_NONNULL_END
