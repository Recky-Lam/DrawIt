//
//  DIDrawingToolBar.h
//  DrawIt
//
//  Created by ReckyLin on 2016/10/26.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

typedef enum {
    DIDrawingToolPenSelect = 6001,
    DIDrawingToolLineSize,
    DIDrawingToolColorSelect,
    DIDrawingToolUndo,
    DIDrawingToolDelete,
}DIDrawingTool;

#import <UIKit/UIKit.h>

@protocol DIDrawingToolBarDelegate <NSObject>

@optional

-(void)didClickButtonOnIndex:(NSInteger)index;

@end

@interface DIDrawingToolBar : UIView

@property (nonatomic, assign)id<DIDrawingToolBarDelegate>toolBarDelegate;

@end
