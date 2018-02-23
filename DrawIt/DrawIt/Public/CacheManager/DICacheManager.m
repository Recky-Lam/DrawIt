//
//  YWCacheManager.m
//  NautilusFair
//
//  Created by ywl-ios2 on 15/7/3.
//  Copyright (c) 2015年 peterZhu. All rights reserved.
//

#import "DICacheManager.h"
#import "VFileManager.h"

#define COMMUNITY_CACHE_PREFIX    [NSString stringWithFormat:@"community_cache_user"]
#define PAINT_CACHE_PREFIX        [NSString stringWithFormat:@"paint_cache_user"]

@implementation DICacheManager

+ (void)saveCacheWithArray:(NSArray *)listArray forKey:(NSString *)key
{
    NSString *cachePath = [PATH_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",COMMUNITY_CACHE_PREFIX, key]];
    NSMutableArray *cacheArray = [NSMutableArray arrayWithArray:listArray];
    [NSKeyedArchiver archiveRootObject:cacheArray toFile:cachePath];
}

+ (NSArray *)getCacheWithKey:(NSString *)key
{
    NSString *cachePath = [PATH_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",COMMUNITY_CACHE_PREFIX, key]];
    NSArray *cacheList = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    return cacheList;
}

+ (void)savePaintCacheWithArray:(NSArray *)listArray
{
    NSString *cachePath = [PATH_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_paint",PAINT_CACHE_PREFIX]];
    NSMutableArray *cacheArray = [NSMutableArray arrayWithArray:listArray];
    [NSKeyedArchiver archiveRootObject:cacheArray toFile:cachePath];
}

+ (NSArray *)getPaintCache
{
    NSString *cachePath = [PATH_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_paint",PAINT_CACHE_PREFIX]];
    NSArray *cacheList = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    return cacheList;
}

+ (BOOL)clearCommunityCache
{
    return [VFileManager removeFilesInDirectoryAtPath:PATH_OF_CACHE withPrefix:COMMUNITY_CACHE_PREFIX];
}

+ (BOOL)clearPaintCache
{
    return [VFileManager removeFilesInDirectoryAtPath:PATH_OF_CACHE withPrefix:PAINT_CACHE_PREFIX];
}

+ (NSNumber *)cacheSize
{
    return [VFileManager sizeOfItemAtPath:[NSString stringWithFormat:@"%@",PATH_OF_CACHE]];
}

@end
