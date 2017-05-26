//
//  ViewController.m
//  SliptView
//
//  Created by 朱胡亮 on 2017/5/25.
//  Copyright © 2017年 SAIC. All rights reserved.
//

#import "ViewController.h"
#import "RViewController.h"
#import "LTableViewController.h"

#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define TOUCH_DISTANCE  150
#define RIGHTVIEW_WIDTH  KScreenWidth/2.0

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) RViewController *rvc;
@property (strong, nonatomic) LTableViewController *lvc;


@end

@implementation ViewController
{
    UIPanGestureRecognizer *panGestureRecognizer;
    BOOL _isMoving;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lvc = [LTableViewController new];
    self.rvc = [RViewController new];

    [self addChildViewController:self.lvc];
    self.lvc.view.frame = CGRectMake(0, 0, KScreenWidth/2, KScreenHeight);
    [self.view addSubview:self.lvc.view];
    
    [self addChildViewController:self.rvc];
    self.rvc.view.frame = CGRectMake(KScreenWidth/2, 0, KScreenWidth/2, KScreenHeight);
    [self.view addSubview:self.rvc.view];
    
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGestureRecognizer.delegate = self;
    [self.rvc.view addGestureRecognizer:panGestureRecognizer];
    
    __weak __typeof(self) weakSelf = self;
    self.lvc.showHandle = ^{
        [weakSelf showRightView];
    };
    
    
    self.rvc.hideHandle = ^{
        [weakSelf hideRightView];
    };
    
}

- (void)showRightView {
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.lvc.view.frame = CGRectMake(0, 0, KScreenWidth/2, KScreenHeight);
        weakSelf.rvc.view.frame = CGRectMake(KScreenWidth/2, 0, KScreenWidth/2, KScreenHeight);
        
    }];
}

- (void)hideRightView {
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.lvc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        weakSelf.rvc.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth/2, KScreenHeight);

    }];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x > 0 && point.x < KScreenWidth/2) {
            return YES;
        }
        else {
            return NO;
        }
    }
    return YES;
}


#pragma mark Pan gesture recognizer (Private)

- (void)panGestureRecognized:(UIPanGestureRecognizer *)pan {
    //    CGPoint touchPoint = [pan locationInView:self.view];
    //拖动了多少像素
    CGFloat translationX  = [pan translationInView:self.view].x;
    //拖动的速度
    CGFloat velocityX     = [pan velocityInView:self.view].x;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"UIGestureRecognizerStateBegan");
            _isMoving = velocityX > 0;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (fabs(translationX) > 40) {
                if (_isMoving) [self doMoveViewWithX:translationX];
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"UIGestureRecognizerStateEnded");
            _isMoving = NO;
            [self gestureRecognizerStateEndedWithPointX:translationX];
        }
            break;
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"UIGestureRecognizerStateCancelled");
            _isMoving = NO;
            [self gestureRecognizerStateEndedWithPointX:translationX];
        }
            break;
        default:
            break;
    }
    
}
- (void)doMoveViewWithX:(CGFloat)x {
    
    x = x > self.view.frame.size.width ? self.view.frame.size.width : x;
    x = x < 0 ? 0 : x;
    CGRect rightframe = CGRectMake(KScreenWidth - RIGHTVIEW_WIDTH + x, 0, RIGHTVIEW_WIDTH, KScreenHeight);
    self.rvc.view.frame = rightframe;
    
}

- (void)gestureRecognizerStateEndedWithPointX:(CGFloat)x {
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (x < TOUCH_DISTANCE) {
            weakSelf.lvc.view.frame = CGRectMake(0, 0, KScreenWidth/2, KScreenHeight);
            weakSelf.rvc.view.frame = CGRectMake(KScreenWidth/2, 0, KScreenWidth/2, KScreenHeight);
        }else {
            weakSelf.lvc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
            weakSelf.rvc.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth/2, KScreenHeight);
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
