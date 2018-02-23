//
//  DIBaseViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIBaseViewController.h"
#import "DINavgationController.h"

@interface DIBaseViewController ()

@end

@implementation DIBaseViewController
@synthesize universalDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    
    [self.view setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+kStatusBarHeight, kScreenWidth, kScreenHeight-kTopBarHeight)];
    [self.view addSubview:self.contentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBackgroundColor:DIColorDarkGray];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

-(void)loadViewController:(DIBaseViewController *)viewController;
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)presentController:(DIBaseViewController *)viewController
{
    DINavgationController *nav = [[DINavgationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:^{}];
}

-(void)setTitle:(NSString *)title
     backButton:(BOOL)showBackButton
{
    
    if (showBackButton){
        [self setLeftItem:@"nav_bar_back"];
    }else{
        [self setLeftItem:@""];
    }
    
    if (title && [title isKindOfClass:[NSString class]] && [title length]>0){
        self.navigationTitle = title;
    }
}

- (void)setLeftItem:(NSString *)imagename
{
    if (!isValidString(imagename)) {
        self.navigationLeftButton = nil;
        return;
    }
    DZXBarButtonItem *leftBtn;
    if (Image(imagename)) {
        leftBtn = [DZXBarButtonItem buttonWithImageNormal:Image(imagename)
                                            imageSelected:Image([imagename stringByAppendingString:@"_hl"])];
    }else{
        leftBtn = [DZXBarButtonItem buttonWithTitle:imagename];
    }
    
    [leftBtn addTarget:self
                action:@selector(back:)
      forControlEvents:UIControlEventTouchUpInside];
    self.navigationLeftButton = leftBtn;
}


- (void)setRightItem:(NSString *)imagename
{
    if (!isValidString(imagename)) {
        self.navigationRightButton = nil;
        return;
    }
    DZXBarButtonItem *rightBtn;
    if (Image(imagename)) {
        rightBtn = [DZXBarButtonItem buttonWithImageNormal:Image(imagename)
                                             imageSelected:Image([imagename stringByAppendingString:@"_hl"])];
    }else{
        rightBtn = [DZXBarButtonItem buttonWithTitle:imagename];
    }
    
    
    [rightBtn addTarget:self
                 action:@selector(rightBarButtonItemAction:)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationRightButton = rightBtn;
}


- (void)rightBarButtonItemAction:(UIButton *)btn
{
    
}

- (void)back:(UIButton *)btn
{
    if(![self.navigationController popViewControllerAnimated:YES]){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
