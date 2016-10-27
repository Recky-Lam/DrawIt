//
//  DILineModel.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/27.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DIPenModel.h"

@interface DIPointModel : NSObject

@property (nonatomic, strong) DIPenModel *pen;
@property (nonatomic) CGPoint location;

@end
