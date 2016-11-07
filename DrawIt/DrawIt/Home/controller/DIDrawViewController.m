//
//  DIDrawViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawViewController.h"
#import "DIColorPickerViewController.h"

@interface DIDrawViewController ()
<DIDrawingToolBarDelegate,
DIBaseViewControllerDelegate>

@property (nonatomic, strong) DIDrawingView *canvans;
@property (nonatomic, strong) DIDrawingToolBar *toolBar;

@property (nonatomic) CGFloat defaultLinesize;
@property (nonatomic) DIPenType defaultPentype;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *lastColor;

@end

@implementation DIDrawViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.defaultLinesize = 15.0f;
        self.defaultPentype = DIPenTypeRoundHeadPen;
        self.defaultColor = BlackColor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"画吧画吧画吧" backButton:YES];
    
    [self.contentView setHeight:self.contentView.height - 84];
    
    UIButton *save = [UIButton createButton:CGRectMake(0, 0, 33, 33) action:@selector(saveCurrentImage:) delegate:self normalImage:Image(@"nav_save") highlightedImage:Image(@"nav_save") title:nil font:nil color:nil];
    UIButton *share = [UIButton createButton:CGRectMake(0, 0, 33, 33) action:nil delegate:self normalImage:Image(@"nav_share") highlightedImage:Image(@"nav_share") title:nil font:nil color:nil];
    
    [self setNavigationRightButtons:@[save, share]];
    
    self.canvans = [[DIDrawingView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.canvans setBackgroundColor:WhiteColor];
    [self.contentView addSubview:self.canvans];
    
    self.toolBar = [[DIDrawingToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - 128, kScreenWidth, 128)];
    [self.toolBar setToolBarDelegate:self];
    
    [self.view addSubview:self.toolBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    NSArray *pointsArray = [touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    
    DIPointModel *point = [[DIPointModel alloc] init];
    point.location = lastPoint;
    point.pen.pentype = self.defaultPentype;
    point.pen.lineWidth = [NSNumber numberWithFloat:self.defaultLinesize];
    point.pen.lineColor = self.defaultColor;
    
    [self.canvans addPointsToDataSource:point];
    [self.canvans setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *pointsArray = [touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    
    DIPointModel *point = [[DIPointModel alloc] init];
    point.location = lastPoint;
    point.pen.pentype = self.defaultPentype;
    point.pen.lineWidth = [NSNumber numberWithFloat:self.defaultLinesize];
    point.pen.lineColor = self.defaultColor;
    
    [self.canvans addPointsToDataSource:point];
    [self.canvans setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.canvans saveCurrentPath];
}

- (void)saveCurrentImage:(UIButton *)button
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    UIImage *picture = [self.contentView screenshotWithQuality:1];
    
    DIPaintInfoModel *paint = [[DIPaintInfoModel alloc] init];
    paint.paintPaths = [NSArray arrayWithArray:self.canvans.historyPoints];
    paint.thumbImage = picture;
    
    NSMutableArray *localCache = [NSMutableArray arrayWithArray:[DICacheManager getPaintCache]];
    [localCache addObject:paint];
    
    [DICacheManager savePaintCacheWithArray:localCache];
    
    UIImageWriteToSavedPhotosAlbum(picture, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SavedImageNotifacation object:nil userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
            [self selectColor];
            break;
            
        case DIDrawingToolUndo:
            [self.canvans undoLastAction];
            break;
            
        case DIDrawingToolDelete:
            [self.canvans removeAllPoints];
            break;
            
        default:
            break;
    }
}

- (void)selectColor
{
    DIColorPickerViewController *picker = [[DIColorPickerViewController alloc] init];
    [picker setUniversalDelegate:self];
    [self presentController:picker];
}

- (void)didSelectPentype:(DIPenType)index
{
    if (index == DIPenTypeEraser) {
        self.defaultPentype = DIPenTypeEraser;
        self.lastColor = self.defaultColor;
        self.defaultColor = WhiteColor;
    }
    else {
        self.defaultColor = self.lastColor;
        self.defaultPentype = index;
    }
}

- (void)didSelectLineSize:(CGFloat)size
{
    self.defaultLinesize = size;
}

- (void)didFinishAciton:(id)obj1
{
    self.defaultColor = (UIColor *)obj1;
    self.lastColor = self.defaultColor;
}

@end
