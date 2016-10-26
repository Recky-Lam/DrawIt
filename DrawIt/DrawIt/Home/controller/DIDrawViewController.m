//
//  DIDrawViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawViewController.h"

@interface DIDrawViewController ()
<DIDrawingToolBarDelegate>

@property (nonatomic, strong) DIDrawingView *canvans;
@property (nonatomic, strong) DIDrawingToolBar *toolBar;
@end

@implementation DIDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"画吧画吧画吧" backButton:YES];
    
    [self.contentView setHeight:self.contentView.height - 64];
    
    UIButton *save = [UIButton createButton:CGRectMake(0, 0, 33, 33) action:@selector(saveCurrentImage:) delegate:self normalImage:Image(@"nav_save") highlightedImage:Image(@"nav_save") title:nil font:nil color:nil];
    UIButton *share = [UIButton createButton:CGRectMake(0, 0, 33, 33) action:nil delegate:self normalImage:Image(@"nav_share") highlightedImage:Image(@"nav_share") title:nil font:nil color:nil];
    
    [self setNavigationRightButtons:@[save, share]];
    self.canvans = [[DIDrawingView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.canvans setBackgroundColor:WhiteColor];
    [self.contentView addSubview:self.canvans];
    
    self.toolBar = [[DIDrawingToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - 64, kScreenWidth, 64)];
    [self.toolBar setToolBarDelegate:self];
    
    [self.view addSubview:self.toolBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    NSArray *pointsArray = [touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    [self.canvans addPointsToDataSource:lastPoint];
    [self.canvans setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *pointsArray = [touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    [self.canvans addPointsToDataSource:lastPoint];
    [self.canvans setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.canvans saveCurrentPath];
    NSLog(@"%@", @"touches end");
}

- (void)saveCurrentImage:(UIButton *)button
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    UIImage *picture = [self.contentView screenshotWithQuality:1];

    UIImageWriteToSavedPhotosAlbum(picture, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }
}

- (void)didClickButtonOnIndex:(NSInteger)index
{
    switch (index) {
        case DIDrawingToolPenSelect:
            
            break;
        case DIDrawingToolLineSize:
            
            break;
        case DIDrawingToolColorSelect:
            
            break;
        case DIDrawingToolUndo:
            [self.canvans undoLastAction];
            
            break;
        default:
            break;
    }
}

@end
