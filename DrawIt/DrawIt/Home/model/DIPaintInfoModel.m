//
//  DIPaintInfoModel.m
//  DrawIt
//
//  Created by ReckyLin on 2016/11/7.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIPaintInfoModel.h"

@interface DIPaintInfoModel ()
<NSCoding>

@end

@implementation DIPaintInfoModel

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.thumbImage = [decoder decodeObjectForKey:@"thumbImage"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.thumbImage forKey:@"thumbImage"];

}


@end
