//
//  DIDrawingView.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawingView.h"

@implementation DIDrawingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.movePoints = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.movePoints = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置笔冒
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置画线的连接处　拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //画之前线
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
//    //画自己的
//    if ([self.movePoints  count] > 0) {
//        for (int i=0; i<[self.movePoints count]; i++) {
//            NSArray* tempArray=[NSArray arrayWithArray:[myallline objectAtIndex:i]];
//            
//            if ([myallColor count]>0) {
//                segmentColor= [DrawPaletteView colorWithHexString:myallColor[i]].CGColor;
//                Intsegmentwidth=[[myallwidth objectAtIndex:i]floatValue]+1;
//            }
//            if ([tempArray count]>1) {
//                CGContextBeginPath(context);
//                CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
//                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
//                
//                for (int j=0; j<[tempArray count]-1; j++) {
//                    CGPoint myEndPoint=[[tempArray objectAtIndex:j+1] CGPointValue];
//                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
//                }
//                CGContextSetStrokeColorWithColor(context, segmentColor);
//                CGContextSetLineWidth(context, Intsegmentwidth);
//                CGContextStrokePath(context);
//            }
//        }
//    }
    //画当前的线
    if ([self.movePoints count] > 1) {
        CGContextBeginPath(context);
        //起点
        CGPoint myStartPoint=[[self.movePoints objectAtIndex:0]   CGPointValue];
        CGContextMoveToPoint(context,    myStartPoint.x, myStartPoint.y);
        //把move的点全部加入　数组
        for (int i=0; i<[self.movePoints count]-1; i++) {
            CGPoint myEndPoint=  [[self.movePoints objectAtIndex:i+1] CGPointValue];
            CGContextAddLineToPoint(context, myEndPoint.x,   myEndPoint.y);
        }
        //在颜色和画笔大小数组里面取不相应的值
        segmentColor= [UIColor blackColor].CGColor;
        Intsegmentwidth = 10.0f;
        //绘制画笔颜色
        CGContextSetStrokeColorWithColor(context, segmentColor);
        CGContextSetFillColorWithColor (context,  segmentColor);
        //绘制画笔宽度
        CGContextSetLineWidth(context, Intsegmentwidth);
        //把数组里面的点全部画出来
        CGContextStrokePath(context);
    }
}

- (void)addPointsToDataSource:(CGPoint)point
{
    [self.movePoints addObject:[NSValue valueWithCGPoint:point]];
    
    NSLog(@"points count = %ld", self.movePoints.count);
}

- (void)removeAllPoints
{
    [self.movePoints removeAllObjects];
}

@end
