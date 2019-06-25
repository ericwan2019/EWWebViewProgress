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

@interface EWWebViewProgressProxy : NSObject


/**
 set proxy webview（wkwebview / uiwebview)

 @param webView proxy webview
 */
- (void)setProxyWebView:(id)webView;

@end

NS_ASSUME_NONNULL_END
