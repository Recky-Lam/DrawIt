//
//  YWCacheManager.h
//  NautilusFair
//
//  Created by ywl-ios2 on 15/7/3.
//  Copyright (c) 2015年 peterZhu. All rights reserved.
//
#import <Foundation/Foundation.h>

static NSString * const kCacheHomeData                           = @"cacheHomeData";

@interface DICacheManager : NSObject

+ (void)saveCacheWithArray:(NSArray *)listArray forKey:(NSString *)key;
+ (void)savePaintCacheWithArray:(NSArray *)listArray;

+ (NSArray *)getCacheWithKey:(NSString *)key;
+ (NSArray *)getPaintCache;

+ (BOOL)clearCommunityCache;
+ (BOOL)clearPaintCache;

+ (NSNumber *)cacheSize;

@end
