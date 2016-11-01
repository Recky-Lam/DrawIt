//
//  DIDrawingToolBar.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/26.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawingToolBar.h"

@interface DIDrawingToolBar ()

@property (nonatomic) CGRect originalFrame;

@property (nonatomic, strong) UIButton *penShapeButton;
@property (nonatomic, strong) UIButton *lineSizeButton;
@property (nonatomic, strong) UIButton *colorButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIView *whiteCover;
@property (nonatomic, strong) UIView *penFunctionView;
@property (nonatomic, strong) UIView *linesizeFunctionView;

@property (nonatomic) BOOL isChildFunctionViewShow;
@property (nonatomic) NSInteger lastFunction;

@property (nonatomic, strong) UIButton *roundPen;
@property (nonatomic, strong) UIButton *markPen;
@property (nonatomic, strong) UIButton *eraser;

@property (nonatomic, strong) UISlider *sizeSlider;
@property (nonatomic, strong) UILabel *lineSize;

@end

@implementation DIDrawingToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.originalFrame = frame;
        
        [self setSize:CGSizeMake(kScreenWidth, 128)];
        
        self.isChildFunctionViewShow = NO;
        
        [self setBackgroundColor:ClearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self addSubview:self.penFunctionView];
    [self addSubview:self.linesizeFunctionView];
    
    [self buildPenSelect];
    [self buildLineSizeSelect];
    
    [self.penFunctionView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.penFunctionView autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 64)];
    
    [self.linesizeFunctionView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.linesizeFunctionView autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 64)];
    
    [self addSubview:self.whiteCover];
    
    [self.whiteCover autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.whiteCover autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 64)];

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

    if (!self.isChildFunctionViewShow) {
 
        self.lastFunction = button.tag;
        
        self.isChildFunctionViewShow = !self.isChildFunctionViewShow;

        [UIView animateWithDuration:0.1 animations:^{
            if (button.tag == DIDrawingToolPenSelect) {
                [self.penFunctionView setFrame:CGRectMake(0, 0, kScreenWidth, 64)];
            }
            else if (button.tag == DIDrawingToolLineSize)
            {
                [self.linesizeFunctionView setFrame:CGRectMake(0, 0, kScreenWidth, 64)];
            }

        }];
        
    }else if (self.lastFunction == button.tag) {

        self.isChildFunctionViewShow = !self.isChildFunctionViewShow;
        self.lastFunction = button.tag;

        [UIView animateWithDuration:0.1 animations:^{
            [self.linesizeFunctionView setFrame:CGRectMake(0, 64, kScreenWidth, 64)];

            [self.penFunctionView setFrame:CGRectMake(0, 64, kScreenWidth, 64)];
        }];
    }
    else {
        
        self.lastFunction = button.tag;
        
        [UIView animateWithDuration:0.1 animations:^{
            if (button.tag == DIDrawingToolPenSelect) {
                [self.linesizeFunctionView setFrame:CGRectMake(0, 64, kScreenWidth, 64)];
            }
            else if (button.tag == DIDrawingToolLineSize)
            {
                [self.penFunctionView setFrame:CGRectMake(0, 64, kScreenWidth, 64)];

            }
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                if (button.tag == DIDrawingToolPenSelect) {
                    [self.penFunctionView setFrame:CGRectMake(0, 0, kScreenWidth, 64)];
                }
                else if (button.tag == DIDrawingToolLineSize)
                {
                    [self.linesizeFunctionView setFrame:CGRectMake(0, 0, kScreenWidth, 64)];
                }

            }];
            
        }];
    }
    
}

- (void)buildPenSelect
{
    [self.penFunctionView addSubview:self.roundPen];
    [self.penFunctionView addSubview:self.markPen];
    [self.penFunctionView addSubview:self.eraser];
    
    [self.roundPen autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 3, 64)];
    [self.markPen autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 3, 64)];
    [self.eraser autoSetDimensionsToSize:CGSizeMake(kScreenWidth / 3, 64)];

    [self.roundPen autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.markPen autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.eraser autoPinEdgeToSuperviewEdge:ALEdgeTop];

    [self.roundPen autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.markPen autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.roundPen];
    [self.eraser autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.markPen];
    
}

- (void)buildLineSizeSelect
{
    [self.linesizeFunctionView addSubview:self.sizeSlider];
    [self.linesizeFunctionView addSubview:self.lineSize];
    
    [self.lineSize autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.lineSize autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:24.5];
    
    [self.sizeSlider autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [self.sizeSlider autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    

    [self.sizeSlider autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.lineSize withOffset:15];
    
}

- (void)penSelected:(UIButton *)button
{
    if ([self.toolBarDelegate respondsToSelector:@selector(didSelectPentype:)]) {
        [self.toolBarDelegate didSelectPentype:button.tag];
    }
}

- (void)lineSizeSelected:(UISlider *)slider
{
    [self.lineSize setText:[NSString stringWithFormat:@"%.1f", slider.value]];
     
    if ([self.toolBarDelegate respondsToSelector:@selector(didSelectLineSize:)]) {
        [self.toolBarDelegate didSelectLineSize:slider.value];
    }
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
    [_whiteCover setBackgroundColor:DIColorWhite];
    
    return _whiteCover;
}

- (UIView *)penFunctionView
{
    if (!_penFunctionView) {
        _penFunctionView = [UIView newAutoLayoutView];
    }
    
    [_penFunctionView setBackgroundColor:DIColorLightWhite];
    _penFunctionView.userInteractionEnabled = YES;
    
    return _penFunctionView;
}

- (UIView *)linesizeFunctionView
{
    if (!_linesizeFunctionView) {
        _linesizeFunctionView = [UIView newAutoLayoutView];
    }
    
    [_linesizeFunctionView setBackgroundColor:DIColorLightWhite];
    _linesizeFunctionView.userInteractionEnabled = YES;
    
    return _linesizeFunctionView;
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

- (UIButton *)roundPen
{
    if (!_roundPen) {
        _roundPen = [UIButton newAutoLayoutView];
    }
    [_roundPen setTag:DIPenTypeRoundHeadPen];
    [_roundPen setImage:Image(@"tool_roundpen") forState:UIControlStateNormal];
    [_roundPen addTarget:self action:@selector(penSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    return _roundPen;
}

- (UIButton *)markPen
{
    if (!_markPen) {
        _markPen = [UIButton newAutoLayoutView];
    }
    [_markPen setTag:DIPenTypeMarkPen];
    [_markPen setImage:Image(@"tool_markpen") forState:UIControlStateNormal];
    [_markPen addTarget:self action:@selector(penSelected:) forControlEvents:UIControlEventTouchUpInside];

    return _markPen;
}

- (UIButton *)eraser
{
    if (!_eraser) {
        _eraser = [UIButton newAutoLayoutView];
    }
    [_eraser setTag:DIPenTypeEraser];
    [_eraser setImage:Image(@"tool_eraser") forState:UIControlStateNormal];
    [_eraser addTarget:self action:@selector(penSelected:) forControlEvents:UIControlEventTouchUpInside];

    return _eraser;
}

- (UISlider *)sizeSlider
{
    if (!_sizeSlider) {
        _sizeSlider = [UISlider newAutoLayoutView];
    }
    
    [_sizeSlider addTarget:self action:@selector(lineSizeSelected:) forControlEvents:UIControlEventValueChanged];
    
    _sizeSlider.maximumValue = 50.0f;
    _sizeSlider.minimumValue = 1.0f;
    [_sizeSlider setValue:15.0f];

    return _sizeSlider;
}

- (UILabel *)lineSize
{
    if (!_lineSize) {
        _lineSize = [UILabel newAutoLayoutView];
    }
    
    [_lineSize setFont:SYSTEMFONT(15)];
    [_lineSize setTextColor:DIColorDarkGray];
    
    [_lineSize setText:@"15.0"];
    return _lineSize;
}

@end
