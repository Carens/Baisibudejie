//
//  LJLRecommendCategoryCell.m
//  项目
//
//  Created by LiJiale on 15/7/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLRecommendCategoryCell.h"
#import "LJLRecommendCategory.h"


@interface LJLRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation LJLRecommendCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = LJLRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = LJLRGBColor(220, 10, 20);
}

- (void)setCategory:(LJLRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : LJLRGBColor(78, 78, 78);
}

@end
