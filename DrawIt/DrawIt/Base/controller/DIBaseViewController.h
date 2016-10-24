//
//  DIBaseViewController.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZXViewController.h"

@protocol YWUniversalDelegate <NSObject>

@optional

-(void)didFinishAciton:(id)obj1;

-(void)didFinishAciton:(id)obj1 withInfo:(id)info;

-(void)didFinishAciton:(id)action withObject:(id)obj2 withInfo:(id)info;

@end

@class PPRequest;
@interface DIBaseViewController : DZXViewController
{
    __unsafe_unretained id<YWUniversalDelegate>universalDelegate;
    UIImageView *bgImageView;
}

@property (nonatomic, assign)id<YWUniversalDelegate>universalDelegate;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) PPRequest *task;


- (void)setTitle:(NSString *)title backButton:(BOOL)showBackButton;

-(void)loadViewController:(DIBaseViewController *)viewController;

- (void)presentController:(DIBaseViewController *)viewController;

- (void)setLeftItem:(NSString *)imagename;
- (void)setRightItem:(NSString *)imagename;

-(void)rightBarButtonItemAction:(UIButton *)btn;

-(void)back:(UIButton *)btn;

@end
