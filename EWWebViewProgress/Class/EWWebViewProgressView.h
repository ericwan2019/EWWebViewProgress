//
//  EWWebViewProgressView.h
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/16.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EWWebViewProgressView : UIView

@property (nonatomic, assign) NSTimeInterval barAnimationDuration;  //default 0.1
@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration; //default 0.3
@property (nonatomic, assign) NSTimeInterval fadeOutDelay;          //default 0.1
@property (nonatomic, strong) UIColor *barColor;                    //default RGB(22,126,251)

@property (nonatomic, assign) float progress;


- (void)setProgress:(float)progress animated:(BOOL)animated;

- (void)setProgress:(float)progress;

@end

NS_ASSUME_NONNULL_END
