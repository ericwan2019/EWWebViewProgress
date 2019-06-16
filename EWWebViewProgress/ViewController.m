//
//  ViewController.m
//  EWWebViewProgress
//
//  Created by EricWan on 2019/6/16.
//  Copyright © 2019 EricWan. All rights reserved.
//

#import "ViewController.h"
#import "EWWebViewProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) EWWebViewProgressView *progressView;
@property (nonatomic, assign) float progress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressView = [[EWWebViewProgressView alloc] initWithFrame:CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, 2)];
    [self.view addSubview:self.progressView];
}

- (IBAction)incresss:(id)sender {
    self.progress += 0.1;
    [self.progressView setProgress:self.progress animated:YES];
}

@end
