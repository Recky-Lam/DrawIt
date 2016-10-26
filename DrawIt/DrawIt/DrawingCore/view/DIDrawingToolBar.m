//
//  DIDrawingToolBar.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/26.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawingToolBar.h"

@interface DIDrawingToolBar ()

@property (nonatomic, strong) UIButton *penShapeButton;
@property (nonatomic, strong) UIButton *lineSizeButton;
@property (nonatomic, strong) UIButton *colorButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation DIDrawingToolBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSize:CGSizeMake(kScreenWidth, 64)];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSize:CGSizeMake(kScreenWidth, 64)];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self setBackgroundColor:ClearColor];
    
    [self addSubview:self.penShapeButton];
    [self addSubview:self.lineSizeButton];
    [self addSubview:self.colorButton];
    [self addSubview:self.deleteButton];
    
    [self.penShapeButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.lineSizeButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.colorButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.deleteButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    [self.penShapeButton autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 4, 64)];
    [self.lineSizeButton autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 4, 64)];
    [self.colorButton autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 4, 64)];
    [self.deleteButton autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 4, 64)];

    [self.penShapeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.lineSizeButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.penShapeButton];
    [self.colorButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.lineSizeButton];
    [self.deleteButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.colorButton];

}

- (void)buttonClicked:(UIButton *)button
{
    if ([self.toolBarDelegate respondsToSelector:@selector(didClickButtonOnIndex:)]) {
        [self.toolBarDelegate didClickButtonOnIndex:button.tag];
    }
}

- (UIButton *)penShapeButton
{
    if (!_penShapeButton) {
        _penShapeButton = [UIButton newAutoLayoutView];
    }
    
    [_penShapeButton setImage:Image(@"toolbar_pen_shape") forState:UIControlStateNormal];
    [_penShapeButton setTag:DIDrawingToolPenSelect];
    [_penShapeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _penShapeButton;
}

- (UIButton *)lineSizeButton
{
    if (!_lineSizeButton) {
        _lineSizeButton = [UIButton newAutoLayoutView];
    }
    
    [_lineSizeButton setImage:Image(@"toolbar_line_size") forState:UIControlStateNormal];
    [_lineSizeButton setTag:DIDrawingToolLineSize];
    [_lineSizeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return _lineSizeButton;
}

- (UIButton *)colorButton
{
    if (!_colorButton) {
        _colorButton = [UIButton newAutoLayoutView];
    }
    
    [_colorButton setImage:Image(@"toolbar_color") forState:UIControlStateNormal];
    [_colorButton setTag:DIDrawingToolColorSelect];
    [_colorButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return _colorButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton newAutoLayoutView];
    }
    
    [_deleteButton setImage:Image(@"toolbar_undo") forState:UIControlStateNormal];
    [_deleteButton setTag:DIDrawingToolUndo];
    [_deleteButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return _deleteButton;
}

@end
