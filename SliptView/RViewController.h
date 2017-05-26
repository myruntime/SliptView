//
//  RViewController.h
//  SliptView
//
//  Created by 朱胡亮 on 2017/5/25.
//  Copyright © 2017年 SAIC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HideHandle)();

@interface RViewController : UIViewController


@property (copy, nonatomic) HideHandle hideHandle;

@end
