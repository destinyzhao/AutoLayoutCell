//
//  TestCell.m
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/4.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "TestCell.h"

@interface TestCell()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.viewHeight.constant = arc4random() % 200;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updatecellHeight
{
    CGFloat height = arc4random() % 200;
    if (height < 60) {
        height = 70;
    }
    self.viewHeight.constant = height;
}

@end
