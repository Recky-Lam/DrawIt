//
//  DILineModel.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/27.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIPointModel.h"

@implementation DIPointModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pen = [[DIPenModel alloc] init];
    }
    return self;
}

@end
