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
    //设置笔冒
    CGContextSetLineCap(context, kCGLineCapRound);
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

                CGPoint startPoint = [[pointsArray objectAtIndex:0] CGPointValue];
                [self drawPoint:startPoint Contex:context];
            }
            
            if ([pointsArray count] > 1) {
                
                [self drawLine:pointsArray Contex:context];

            }
        }];
    }
    
    if ([self.movePoints count] == 1) {

        CGPoint startPoint = [[self.movePoints objectAtIndex:0] CGPointValue];
        [self drawPoint:startPoint Contex:context];

    }

    if ([self.movePoints count] > 1) {

        [self drawLine:self.movePoints Contex:context];

    }

}

- (void)drawPoint:(CGPoint)point Contex:(CGContextRef)context
{
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x, point.y);
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
    //在颜色和画笔大小数组里面取不相应的值
    segmentColor = [UIColor blackColor].CGColor;
    Intsegmentwidth = 10.0f;
    
    //绘制画笔颜色
    CGContextSetStrokeColorWithColor(context, segmentColor);
    CGContextSetFillColorWithColor  (context, segmentColor);
    //绘制画笔宽度
    CGContextSetLineWidth(context, Intsegmentwidth);

    CGContextStrokePath(context);

}

- (void)drawLine:(NSArray *)points Contex:(CGContextRef)context
{
    CGContextBeginPath(context);
    
    CGPoint startPoint = [[points objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    //把move的点全部加入　数组
    for (int i = 0; i < [points count] - 1; i++) {
        CGPoint endPoint = [[points objectAtIndex:i + 1] CGPointValue];
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    }
    
    float           Intsegmentwidth;
    CGColorRef      segmentColor;
    
    //在颜色和画笔大小数组里面取不相应的值
    segmentColor = [UIColor blackColor].CGColor;
    Intsegmentwidth = 10.0f;
    
    //绘制画笔颜色
    CGContextSetStrokeColorWithColor(context, segmentColor);
    CGContextSetFillColorWithColor  (context,  segmentColor);
    //绘制画笔宽度
    CGContextSetLineWidth(context, Intsegmentwidth);

    CGContextStrokePath(context);

}

- (void)addPointsToDataSource:(CGPoint)point
{
    [self.movePoints addObject:[NSValue valueWithCGPoint:point]];
}

- (void)saveCurrentPath
{
    [self.historyPoints addObject:[NSArray arrayWithArray:self.movePoints]];
    
//    NSLog(@"total points: %@", self.historyPoints);
//    NSLog(@"saved points: %@", self.movePoints);

    [self.movePoints removeAllObjects];
    
}

- (void)removeAllPoints
{
    [self.historyPoints removeAllObjects];
}

@end
