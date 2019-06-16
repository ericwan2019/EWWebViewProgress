//
//  EWWebViewProgressView.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/16.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "EWWebViewProgressView.h"


@interface EWWebViewProgressView ()
@property (nonatomic, strong) UIView *progressBarView; //进度条
@end


@implementation EWWebViewProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupUIs];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self _setupUIs];
}


- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL canAnimation = progress > 0.0;
    NSTimeInterval duration = (canAnimation && animated) ? _barAnimationDuration : 0.f;
    
    __weak typeof(self) weakSelf = self;
    
    //进行进度条的动画
    [UIView animateWithDuration:duration delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        CGRect frame = strongSelf.progressBarView.frame;
        frame.size.width = progress * CGRectGetWidth(strongSelf.frame);
        strongSelf.progressBarView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    

    NSTimeInterval fadeout = animated ? _fadeAnimationDuration : 0;
    //移除动画
    if (progress >= 1.0) {
        [UIView animateWithDuration:fadeout delay:self.fadeOutDelay options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.progressBarView.alpha = 0;
        } completion:^(BOOL finished) {
            __strong typeof(self) strongSelf = weakSelf;
            CGRect frame = strongSelf.progressBarView.frame;
            frame.size.width = 0;
            strongSelf.progressBarView.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:fadeout delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.progressBarView.alpha = 1.f;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    self.progressBarView.backgroundColor = barColor;
}

#pragma mark - Private
- (void)_setupUIs {
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _barColor =  [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS Safari bar color
    _progressBarView.backgroundColor = _barColor;
    [self addSubview:_progressBarView];
    
    _barAnimationDuration = 0.1;
    _fadeOutDelay = 0.1;
    _fadeAnimationDuration = 0.3;
    self.progress = 0;
}

@end
