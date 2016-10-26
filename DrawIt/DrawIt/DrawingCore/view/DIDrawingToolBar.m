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

@property (nonatomic, strong) UIView *whiteCover;
@property (nonatomic, strong) UIView *childFunctionView;
@property (nonatomic) BOOL isChildFunctionViewShow;
@property (nonatomic) NSInteger lastFunction;

@property (nonatomic, strong) UIButton *roundPen;
@property (nonatomic, strong) UIButton *markPen;

@end

@implementation DIDrawingToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSize:CGSizeMake(kScreenWidth, 64)];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.isChildFunctionViewShow = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [self setBackgroundColor:WhiteColor];
    
    [self addSubview:self.childFunctionView];
    [self.childFunctionView autoPinEdgesToSuperviewEdges];
    
    [self addSubview:self.whiteCover];
    [self.whiteCover autoPinEdgesToSuperviewEdges];
    
    [self.whiteCover addSubview:self.penShapeButton];
    [self.whiteCover addSubview:self.lineSizeButton];
    [self.whiteCover addSubview:self.colorButton];
    [self.whiteCover addSubview:self.deleteButton];
    
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

- (void)animateChildFunctionView:(UIButton *)button
{
    self.lastFunction = button.tag;
    self.isChildFunctionViewShow = !self.isChildFunctionViewShow;

    [UIView animateWithDuration:0.1 animations:^{
        if (!self.isChildFunctionViewShow) {
            self.childFunctionView.y += 64;
        }
        else {
            self.childFunctionView.y -= 64;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)buttonClicked:(UIButton *)button
{
    if ([self.toolBarDelegate respondsToSelector:@selector(didClickButtonOnIndex:)]) {
        [self.toolBarDelegate didClickButtonOnIndex:button.tag];
    }
}

- (void)cleanCanvans
{
    if ([self.toolBarDelegate respondsToSelector:@selector(didClickButtonOnIndex:)]) {
        [self.toolBarDelegate didClickButtonOnIndex:DIDrawingToolDelete];
    }
}

- (UIView *)whiteCover
{
    if (!_whiteCover) {
        _whiteCover = [UIView newAutoLayoutView];
    }
    [_whiteCover setBackgroundColor:WhiteColor];
    
    return _whiteCover;
}

- (UIView *)childFunctionView
{
    if (!_childFunctionView) {
        _childFunctionView = [UIView newAutoLayoutView];
    }
    [_childFunctionView setBackgroundColor:BlackColor];
    
    return _childFunctionView;
}

- (UIButton *)penShapeButton
{
    if (!_penShapeButton) {
        _penShapeButton = [UIButton newAutoLayoutView];
    }
    
    [_penShapeButton setImage:Image(@"toolbar_pen_shape") forState:UIControlStateNormal];
    [_penShapeButton setTag:DIDrawingToolPenSelect];
    [_penShapeButton addTarget:self action:@selector(animateChildFunctionView:) forControlEvents:UIControlEventTouchUpInside];
    
    return _penShapeButton;
}

- (UIButton *)lineSizeButton
{
    if (!_lineSizeButton) {
        _lineSizeButton = [UIButton newAutoLayoutView];
    }
    
    [_lineSizeButton setImage:Image(@"toolbar_line_size") forState:UIControlStateNormal];
    [_lineSizeButton setTag:DIDrawingToolLineSize];
    [_lineSizeButton addTarget:self action:@selector(animateChildFunctionView:) forControlEvents:UIControlEventTouchUpInside];

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
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCanvans)];
    longPressGR.minimumPressDuration = 1.0;
    [_deleteButton addGestureRecognizer:longPressGR];

    return _deleteButton;
}

@end
