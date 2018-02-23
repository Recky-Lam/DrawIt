//
//  DIPaintCollectionViewCell.m
//  DrawIt
//
//  Created by ReckyLin on 2016/11/7.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIPaintCollectionViewCell.h"

@interface DIPaintCollectionViewCell ()

@property (nonatomic) BOOL  didSetupConstraints;

@property (nonatomic, strong) UIImageView *paint;

@end

@implementation DIPaintCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.didSetupConstraints = YES;
        
        [self setBackgroundColor:WhiteColor];
        
        [self addSubview:self.paint];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        [self.paint autoSetDimensionsToSize:CGSizeMake(kScreenWidth/10, kScreenWidth/10)];
        [self.paint autoCenterInSuperview];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)configCellDataWithData:(DIPaintInfoModel *)paint Indexpath:(NSIndexPath *)indexPath
{
    [self.paint setImage:paint.thumbImage];
    
    self.didSetupConstraints = NO;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (UIImageView *)paint
{
    if (!_paint) {
        _paint = [UIImageView newAutoLayoutView];
    }
    
    _paint.backgroundColor = [UIColor whiteColor];
//    [_paint setImage:Image(@"paint_add")];
    return _paint;
}


@end
