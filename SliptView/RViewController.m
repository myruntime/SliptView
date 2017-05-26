//
//  RViewController.m
//  SliptView
//
//  Created by 朱胡亮 on 2017/5/25.
//  Copyright © 2017年 SAIC. All rights reserved.
//

#import "RViewController.h"

@interface RViewController ()
@property (strong, nonatomic) UIWebView *web;
@end

@implementation RViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.web];
    
    UIButton *touchIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchIdButton setTitle:@"sdsdsd" forState:UIControlStateNormal];
    touchIdButton.frame = CGRectMake(0, 0, 100, 100);
    [touchIdButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [touchIdButton addTarget:self action:@selector(touchIdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchIdButton];
    
    // Do any additional setup after loading the view from its nib.
    [self.web  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/LiuYulei001/LYLLateralSpreadsMenu"]]];
}

- (void)touchIdButtonClicked {
    if (self.hideHandle) {
        self.hideHandle();
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
