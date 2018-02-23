//
//  DIPenModel.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/27.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

typedef enum {
    DIPenTypeRoundHeadPen = 6001,
    DIPenTypeMarkPen,
    DIPenTypeEraser,
}DIPenType;

#import <Foundation/Foundation.h>

@interface DIPenModel : NSObject

@property(nonatomic) DIPenType pentype;
@property(nonatomic, strong) NSNumber *lineWidth;
@property(nonatomic, strong) UIColor *lineColor;

@end
