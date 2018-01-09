//
//  UITableView+AutoLayoutCell.h
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/8.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+CellHeightCache.h"

@interface UITableView (AutoLayoutCell)

- (CGFloat)heightForAutoLayoutCellWithIdentifier:(NSString *)identifier cacheKey:(NSString *)key configaurtaion:(void(^)(id cell))configaurtaion;

/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell;

@end
