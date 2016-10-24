//
//  DIDrawViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIDrawViewController.h"

@interface DIDrawViewController ()

@property (nonatomic, strong) DIDrawingView *canvans;

@end

@implementation DIDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"画吧画吧画吧" backButton:YES];
    
    self.canvans = [[DIDrawingView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.canvans setBackgroundColor:WhiteColor];
    
    [self.contentView addSubview:self.canvans];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *pointsArray=[touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    [self.canvans addPointsToDataSource:lastPoint];
    [self.canvans setNeedsDisplay];
    
    NSLog(@"%@", @"touches begin is draging");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *pointsArray=[touches allObjects];
    CGPoint lastPoint = [[pointsArray objectAtIndex:0] locationInView:self.canvans];
    [self.canvans addPointsToDataSource:lastPoint];
    [self.canvans setNeedsDisplay];
    
    NSLog(@"%@", @"touches end");
    
}


@end
