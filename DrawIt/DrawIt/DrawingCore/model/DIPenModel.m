//
//  DIPenModel.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/27.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIPenModel.h"

@implementation DIPenModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.pentype = DIPenTypeRoundHeadPen;
        self.lineWidth = @15;
        self.lineColor = BlackColor;
    }
    return self;
}

@end
