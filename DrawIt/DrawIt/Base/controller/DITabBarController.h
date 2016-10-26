//
//  DITabBarController.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DINavgationController.h"

#import "DIHomeViewController.h"
#import "DIMineViewController.h"

@interface DITabBarController : UITabBarController

@property (strong, nonatomic) DIHomeViewController *homeVC;
@property (strong, nonatomic) DIMineViewController *mineVC;

//初始化tabViewConroller
-(void)initNormalTabViewControllerWithIndex:(NSInteger)index;

@end
