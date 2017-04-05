//
//  DITabBarController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DITabBarController.h"

@interface DITabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) DINavgationController *homeNav;
@property (nonatomic, strong) DINavgationController *mineNav;

@end

@implementation DITabBarController


- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setDelegate:self];
    
    _homeVC = [[DIHomeViewController alloc] init];
    _mineVC = [[DIMineViewController alloc] init];
    
    _homeNav = [[DINavgationController alloc] initWithRootViewController:_homeVC];
    _mineNav = [[DINavgationController alloc] initWithRootViewController:_mineVC];
    
    [self initNormalTabViewControllerWithIndex:0];
    
    // Do any additional setup after loading the view.
}

//初始化tabViewConroller
-(void)initNormalTabViewControllerWithIndex:(NSInteger)index
{
    _homeVC.tabBarItem = [self createTabBarItem:@"Draw" normalImage:@"tab_home" selectedImage:@"tab_home_hl" itemTag:0];
    _mineVC.tabBarItem = [self createTabBarItem:@"Pixel" normalImage:@"tab_mine" selectedImage:@"tab_mine_hl" itemTag:1];

    [self.tabBar setBarStyle:UIBarStyleDefault];
    NSArray *tabItems = [NSArray arrayWithObjects:_homeNav, _mineNav, nil];
    self.viewControllers = tabItems;
    if (index < tabItems.count) {
        [self setSelectedIndex:index];
    }
}

- (UITabBarItem *) createTabBarItem:(NSString *)strTitle
                        normalImage:(NSString *)strNormalImg
                      selectedImage:(NSString *)strSelectedImg
                            itemTag:(NSInteger)intTag
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:intTag];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(153, 153, 153, 1), NSForegroundColorAttributeName, nil]
                        forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(51, 51, 51, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    [item setTitle:strTitle];
    
    [item setImage:[[UIImage imageNamed:strNormalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:strSelectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return item;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


@end
