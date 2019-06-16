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

@property (nonatomic, assign) float progress;                       //progress 0.0...1.0， default 0, bar width = 0


/**
 update progress bar progress with animation

 @param progress progress 0.0...1.0
 @param animated animated
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;

/**
 update progress bar progress without animation
 
 @param progress progress 0.0...1.0
 */
- (void)setProgress:(float)progress;

@end

NS_ASSUME_NONNULL_END
