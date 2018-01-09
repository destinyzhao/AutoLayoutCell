//
//  UITableView+AutoLayoutCell.m
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/8.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "UITableView+AutoLayoutCell.h"
#import <objc/runtime.h>

@implementation UITableView (AutoLayoutCell)


- (CGFloat)heightForAutoLayoutCellWithIdentifier:(NSString *)identifier cacheKey:(NSString *)key configaurtaion:(void (^)(id))configaurtaion
{
    if (identifier.length == 0 || key.length == 0) {
        return 0;
    }
    
    /*先从缓存中取 **/
    CGFloat cachedHeight = [self heightOfCellForKey:key];
    if (cachedHeight >0) {
        return cachedHeight;
    }
    else {
        //计算cell 的高度并且缓存进去
        CGFloat height = [self heightForCellWithIdentifier:identifier configuration:configaurtaion];
        /* 缓存cell的高度**/
        [self cacheCellHeight:height forKey:key];
        return height;
    }
}

/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell
{
    [self removeAllHeightCacheOfCell];
}

#pragma mark - 私有方法
/* 通过自动布局 来计算cell的高度 **/
- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration {
    
    UITableViewCell *templateLayoutCell = [self cellForReuseIdentifier:identifier];
    /*手动调用确保cell 在显示屏幕中 **/
    [templateLayoutCell prepareForReuse];

    if (configuration) {
        configuration(templateLayoutCell);
    }

    return [self systemFittingHeightForConfiguratedCell:templateLayoutCell];
}

/* 获取 cell **/
- (UITableViewCell *)cellForReuseIdentifier:(NSString *)identifier {
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
      
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
    
}

/* 获取 cell 自动布局高度 **/
- (CGFloat)systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell {
    /* 获得cell 的宽度 **/
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    
    /* 修复cell 的宽度 **/
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    if (contentViewWidth <= 0) {
        return 0;
    }
    
    CGSize fittingSize = CGSizeZero;
    
    NSLayoutConstraint *tempWidthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:tempWidthConstraint];
    // 自动布局的系统方法 计算高度
    fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    /* 计算完后 再删除 **/
    [cell.contentView removeConstraint:tempWidthConstraint];
    /* 修复线的1个像素 **/
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
    }
    return fittingSize.height;
}

@end
