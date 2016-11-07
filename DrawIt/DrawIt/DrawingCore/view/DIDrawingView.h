 //
//  DIDrawingView.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIPointModel.h"

@interface DIDrawingView : UIView

@property (nonatomic, strong) NSMutableArray *movePoints;
@property (nonatomic, strong) NSMutableArray *historyPoints;

- (void)addPointsToDataSource:(DIPointModel *)point;
- (void)saveCurrentPath;
- (void)undoLastAction;
- (void)removeAllPoints;

@end
