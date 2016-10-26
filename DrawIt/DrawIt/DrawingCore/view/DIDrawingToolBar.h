//
//  DIDrawingToolBar.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/26.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

typedef enum {
    DIDrawingToolPenSelect = 1,
    DIDrawingToolLineSize = 2,
    DIDrawingToolColorSelect = 3,
    DIDrawingToolUndo = 4,
}DIDrawingTool;

#import <UIKit/UIKit.h>

@protocol DIDrawingToolBarDelegate <NSObject>

@optional

-(void)didClickButtonOnIndex:(NSInteger)index;

@end

@interface DIDrawingToolBar : UIView

@property (nonatomic, assign)id<DIDrawingToolBarDelegate>toolBarDelegate;

@end
