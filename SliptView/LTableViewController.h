//
//  LTableViewController.h
//  SliptView
//
//  Created by 朱胡亮 on 2017/5/25.
//  Copyright © 2017年 SAIC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShowHandle)();


@interface LTableViewController : UITableViewController
@property (copy, nonatomic) ShowHandle showHandle;


@end
