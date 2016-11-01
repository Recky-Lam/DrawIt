//
//  DIDrawingView.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawingView.h"

@interface DIDrawingView ()

@property (nonatomic, strong) NSMutableArray *historyPoints;

@end

@implementation DIDrawingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.movePoints = [NSMutableArray array];
        self.historyPoints = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.movePoints = [NSMutableArray array];
        self.historyPoints = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //设置画线的连接处　拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //画之前线
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
    //在颜色和画笔大小数组里面取不相应的值
    segmentColor = [UIColor blackColor].CGColor;
    Intsegmentwidth = 10.0f;

    if ([self.historyPoints count] > 0) {
        [self.historyPoints enumerateObjectsUsingBlock:^(NSMutableArray *pointsArray, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([pointsArray count] == 1) {

                DIPointModel *point = pointsArray[0];
                [self drawPoint:point Contex:context];
            }
            
            if ([pointsArray count] > 1) {
                
                [self drawLine:pointsArray Contex:context];

            }
        }];
    }
    
    if ([self.movePoints count] == 1) {

        DIPointModel *point = self.movePoints[0];
        [self drawPoint:point Contex:context];

    }

    if ([self.movePoints count] > 1) {

        [self drawLine:self.movePoints Contex:context];

    }

}

- (void)drawPoint:(DIPointModel *)point Contex:(CGContextRef)context
{
    switch (point.pen.pentype) {
        case DIPenTypeMarkPen:
            //设置笔冒
            CGContextSetLineCap(context, kCGLineCapSquare);
            break;
        case DIPenTypeRoundHeadPen:
            CGContextSetLineCap(context, kCGLineCapRound);
            break;
        default:
            break;
    }
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, point.location.x, point.location.y);
    CGContextAddLineToPoint(context, point.location.x, point.location.y);
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
    //在颜色和画笔大小数组里面取不相应的值
    segmentColor = point.pen.lineColor.CGColor;
    Intsegmentwidth = [point.pen.lineWidth floatValue];
    
    //绘制画笔颜色
    CGContextSetStrokeColorWithColor(context, segmentColor);
    CGContextSetFillColorWithColor  (context, segmentColor);
    //绘制画笔宽度
    CGContextSetLineWidth(context, Intsegmentwidth);

    CGContextStrokePath(context);

}

- (void)drawLine:(NSArray *)points Contex:(CGContextRef)context
{
    DIPointModel *point = points[0];
 
    switch (point.pen.pentype) {
        case DIPenTypeMarkPen:
            //设置笔冒
            CGContextSetLineCap(context, kCGLineCapSquare);
            break;
        case DIPenTypeRoundHeadPen:
            CGContextSetLineCap(context, kCGLineCapRound);
            break;
        case DIPenTypeEraser:
            CGContextSetLineCap(context, kCGLineCapRound);
            break;
        default:
            break;
    }
    
    CGContextBeginPath(context);
    
    CGPoint startPoint = point.location;
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    //把move的点全部加入　数组
    for (int i = 0; i < [points count] - 1; i++) {
        DIPointModel *endPoint = [points objectAtIndex:i + 1];
        CGPoint endPointLocation = endPoint.location;
        CGContextAddLineToPoint(context, endPointLocation.x, endPointLocation.y);
    }
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
    //在颜色和画笔大小数组里面取不相应的值
    segmentColor = point.pen.lineColor.CGColor;
    Intsegmentwidth = [point.pen.lineWidth floatValue];
    
    //绘制画笔颜色
    CGContextSetStrokeColorWithColor(context, segmentColor);
    CGContextSetFillColorWithColor  (context,  segmentColor);
    //绘制画笔宽度
    CGContextSetLineWidth(context, Intsegmentwidth);

    CGContextStrokePath(context);

}

- (void)addPointsToDataSource:(DIPointModel *)point
{
    [self.movePoints addObject:point];
}

- (void)saveCurrentPath
{
    [self.historyPoints addObject:[NSArray arrayWithArray:self.movePoints]];

    [self.movePoints removeAllObjects];
    
}

- (void)undoLastAction
{
    [self.historyPoints removeLastObject];
    [self setNeedsDisplay];
}

- (void)removeAllPoints
{
    [self.historyPoints removeAllObjects];
    [self setNeedsDisplay];
}

@end
