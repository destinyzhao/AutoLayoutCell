//
//  UITableView+CellHeightCache.m
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/8.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "UITableView+CellHeightCache.h"
#import <objc/runtime.h>

@interface CellHeightCache()

/* 竖着的 高度缓存数组**/
@property (nonatomic, strong) NSCache *heightValuesForPortrait;
/* 全屏的 高度缓存数组**/
@property (nonatomic, strong) NSCache *heightValuesForLandscape;


/* 把某个高度 缓存到 key 中去**/
- (void)cacheHeight:(CGFloat)height forKey:(NSString *)key;
/* 从key 中取出某个高度 **/
- (CGFloat)heightForKey:(NSString *)key;
/* 清空某个Key的缓存的高度 **/
- (void)removeHeightForKey:(NSString *)key;
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCache;

@end

@implementation CellHeightCache
#pragma mark - 初始化数据
/*初始化数据源 **/
- (NSCache *)heightValuesForPortrait
{
    if (_heightValuesForPortrait == nil) 
    {
        _heightValuesForPortrait = [[NSCache alloc]init];
    }
    return _heightValuesForPortrait;
}

- (NSCache *)heightValuesForLandscape
{
    if (_heightValuesForLandscape == nil) {
        _heightValuesForLandscape = [[NSCache alloc]init];
    }
    return _heightValuesForLandscape;
}


#pragma mark - 私有方法
/* 判断出是 竖屏 还是 横屏中的某个值 **/
- (NSCache *)heightValuesForCurrentOrientation
{
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? self.heightValuesForPortrait:self.heightValuesForLandscape;
}

/* 通过number类型转换成CGFloat 类型**/
- (CGFloat)getFloatValueWithNumber:(NSNumber *)number
{
#if CGFLOAT_IS_DOUBLE
    return [number doubleValue];
#else
    return [number floatValue];
#endif
    
}

#pragma mark - 公共接口
/* 把某个高度 缓存到 key 中去**/
- (void)cacheHeight:(CGFloat)height forKey:(NSString *)key
{
    if (height > 0) {
        [self.heightValuesForCurrentOrientation setObject:@(height) forKey:key];
    }
}

/* 从key 中取出某个高度 **/
- (CGFloat)heightForKey:(NSString *)key {
    
    NSNumber * number = [self.heightValuesForCurrentOrientation objectForKey:key];
    return [self getFloatValueWithNumber:number];
}

/* 清空某个Key的缓存的高度 **/
- (void)removeHeightForKey:(NSString *)key {
    
    [self.heightValuesForPortrait  removeObjectForKey:key];
    [self.heightValuesForLandscape removeObjectForKey:key];
}
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCache {
    
    [self.heightValuesForPortrait  removeAllObjects];
    [self.heightValuesForLandscape removeAllObjects];
}

@end


@implementation UITableView (CellHeightCache)

- (CellHeightCache *)cellHeightCache{
    CellHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (cache == nil) {
        cache = [[CellHeightCache alloc]init];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

/* 把某个高度 缓存到 key 中去**/
- (void)cacheCellHeight:(CGFloat)height forKey:(NSString *)key
{
    [self.cellHeightCache cacheHeight:height forKey:key];
}

/* 从key 中取出某个高度 **/
- (CGFloat)heightOfCellForKey:(NSString *)key
{
    return [self.cellHeightCache heightForKey:key];
}

/* 清空某个Key的缓存的高度 **/
- (void)removeHeightCacheOfCellForKey:(NSString *)key
{
    [self.cellHeightCache removeHeightForKey:key];
}

/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell
{
    [self.cellHeightCache removeAllHeightCache];
}

@end
