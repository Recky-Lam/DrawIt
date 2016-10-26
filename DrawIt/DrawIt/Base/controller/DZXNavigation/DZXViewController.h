//
//  DZXViewController.h
//  DZXNavigationController
//
//  Created by Kenway on 15/12/21.
//  Copyright © 2015年 Zahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZXBarButtonItem.h"

@interface DZXViewController : UIViewController

@property (nonatomic, strong) UIView *navigationView; //自定义导航栏
@property (nonatomic, strong) UIControl *navigationTitleView; //标题视图
@property (nonatomic, copy) NSString *navigationTitle; //标题文字
@property (nonatomic, strong) UIColor *navigationBackgroundColor; //导航栏背景色
@property (nonatomic, strong) UIButton *navigationLeftButton; //导航栏左侧按钮
@property (nonatomic, strong) UIButton *navigationRightButton; //导航栏右侧按钮
@property (nonatomic, copy) NSArray<UIButton *> *navigationLeftButtons; //导航栏左侧按钮集合（最多两个）
@property (nonatomic, copy) NSArray<UIButton *> *navigationRightButtons; //导航栏右侧按钮集合（最多两个）
@property (nonatomic, assign) CGFloat navigationAlphaValue; //导航栏背景透明度
@property (nonatomic, strong) UILabel *labelTitle;


- (void)setNavigationAlpha:(CGFloat)navigationAlpha;
@end
