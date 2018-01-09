//
//  UITableView+CellHeightCache.h
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/8.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellHeightCache:NSObject

@end

@interface UITableView (CellHeightCache)

/* 清空某个Key的缓存的高度 **/
- (void)removeHeightCacheOfCellForKey:(NSString *)key;
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell;

/* 把某个高度 缓存到 key 中去**/
- (void)cacheCellHeight:(CGFloat)height forKey:(NSString *)key;
/* 从key 中取出某个高度 **/
- (CGFloat)heightOfCellForKey:(NSString *)key;


@end
