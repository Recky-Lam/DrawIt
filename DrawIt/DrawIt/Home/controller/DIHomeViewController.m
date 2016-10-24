//
//  DIHomeViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIHomeViewController.h"
#import "DIDrawViewController.h"

@interface DIHomeViewController ()

@property (nonatomic, strong) UIButton *drawButton;

@end

@implementation DIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Draw It" backButton:NO];
    
    [self.contentView setBackgroundColor:RedColor];
    
    [self buildElements];
}

- (void)buildElements
{
    [self.contentView addSubview:self.drawButton];
    
    [self.drawButton autoSetDimensionsToSize:CGSizeMake(100, 100)];
    [self.drawButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:100];
    [self.drawButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:100];
    
}

- (UIButton *)drawButton
{
    if (!_drawButton) {
        _drawButton = [UIButton newAutoLayoutView];
    }
    
    [_drawButton setTitle:@"draw" forState:UIControlStateNormal];
    [_drawButton addTarget:self action:@selector(drawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _drawButton;
}

- (void)drawButtonAction:(UIButton *)button
{
    [self presentController:[[DIDrawViewController alloc] init]];
}
@end
