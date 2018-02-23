//
//  DIPaintCollectionViewCell.h
//  DrawIt
//
//  Created by ReckyLin on 2016/11/7.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

static NSString *paintCellIdentifier           = @"paintCellIdentifier";

#import <UIKit/UIKit.h>

@interface DIPaintCollectionViewCell : UICollectionViewCell

- (void)configCellDataWithData:(DIPaintInfoModel *)paint Indexpath:(NSIndexPath*)indexPath;

@end
