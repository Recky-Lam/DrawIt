//
//  DIColorPickerViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/11/1.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIColorPickerViewController.h"

@interface DIColorPickerViewController ()
<RSColorPickerViewDelegate>

@property (nonatomic) RSColorPickerView *colorPicker;

@property (nonatomic, strong) UILabel *brightLabel;
@property (nonatomic, strong) UISlider *brightSlider;
@property (nonatomic, strong) UILabel *alphaLabel;
@property (nonatomic, strong) UISlider *alphaSlider;

@end

@implementation DIColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"颜色选择" backButton:YES];
    
    [self setRightItem:@"选择"];
    
    self.colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth-30, kScreenWidth-30)];
    self.colorPicker.cropToCircle = YES;
    [self.colorPicker setBrightness:1];
    [self.colorPicker setBrightness:1];
    [self.colorPicker setDelegate:self];
    
    [self.contentView addSubview:self.colorPicker];
    
    [self.contentView addSubview:self.brightLabel];
    [self.contentView addSubview:self.brightSlider];
    [self.contentView addSubview:self.alphaLabel];
    [self.contentView addSubview:self.alphaSlider];
    
    [self.brightLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.brightLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.brightLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreenWidth];
    
    [self.brightSlider autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.brightSlider autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.brightSlider autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.brightLabel];

    [self.alphaLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.alphaLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.alphaLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.brightSlider];
    
    [self.alphaSlider autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.alphaSlider autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.alphaSlider autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.alphaLabel];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if ([self.universalDelegate respondsToSelector:@selector(didFinishAciton:)]) {
        [self.universalDelegate didFinishAciton:self.colorPicker.selectionColor];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)colorPickerDidChangeSelection:(RSColorPickerView *)colorPicker
{
    NSLog(@"%@", colorPicker.selectionColor);
}

- (void)changeBright:(UISlider *)slider
{
    [self.colorPicker setBrightness:1-slider.value];
}

- (void)changeAlpha:(UISlider *)slider
{
    [self.colorPicker setOpacity:1-slider.value];
}

- (UILabel *)brightLabel
{
    if (!_brightLabel) {
        _brightLabel = [UILabel newAutoLayoutView];
    }
    
    [_brightLabel setText:@"曝光度"];
    [_brightLabel setFont:SYSTEMFONT(15)];
    [_brightLabel setTextAlignment:NSTextAlignmentCenter];
    [_brightLabel setTextColor:DIColorDarkGray];
    
    return _brightLabel;
}

- (UISlider *)brightSlider
{
    if (!_brightSlider) {
        _brightSlider = [UISlider newAutoLayoutView];
    }
    
    [_brightSlider setMinimumValue:0.0f];
    [_brightSlider setMaximumValue:1.0f];
    [_brightSlider setMaximumTrackTintColor:DIColorLightGray];
    [_brightSlider setMinimumTrackTintColor:DIColorDarkGray];
    [_brightSlider addTarget:self action:@selector(changeBright:) forControlEvents:UIControlEventValueChanged];

    return _brightSlider;
}

- (UILabel *)alphaLabel
{
    if (!_alphaLabel) {
        _alphaLabel = [UILabel newAutoLayoutView];
    }
    
    [_alphaLabel setText:@"透明度"];
    [_alphaLabel setFont:SYSTEMFONT(15)];
    [_alphaLabel setTextAlignment:NSTextAlignmentCenter];
    [_alphaLabel setTextColor:DIColorDarkGray];
    
    return _alphaLabel;
}

- (UISlider *)alphaSlider
{
    if (!_alphaSlider) {
        _alphaSlider = [UISlider newAutoLayoutView];
    }
    
    [_alphaSlider setMinimumValue:0.0f];
    [_alphaSlider setMaximumValue:1.0f];
    [_alphaSlider setMaximumTrackTintColor:DIColorLightGray];
    [_alphaSlider setMinimumTrackTintColor:DIColorDarkGray];
    [_alphaSlider addTarget:self action:@selector(changeAlpha:) forControlEvents:UIControlEventValueChanged];
    
    return _alphaSlider;
}
@end
