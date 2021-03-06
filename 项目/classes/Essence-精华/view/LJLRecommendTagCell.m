//
//  LJLRecommendTagCell.m
//  项目
//
//  Created by LiJiale on 15/7/25.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLRecommendTagCell.h"
#import<UIImageView+WebCache.h>
#import "LJLRecommendTag.h"

@interface LJLRecommendTagCell()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;

//名字
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

//订阅数
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;

@end

@implementation LJLRecommendTagCell

- (void)awakeFromNib {
    //通过图层改变为圆形头像
//    self.imageListImageView.layer.cornerRadius = 10;
//    self.imageListImageView.layer.masksToBounds = YES;
}

- (void)setTag:(LJLRecommendTag *)Tag
{
    
    _Tag = Tag;
    [self.imageListImageView setHeader:Tag.image_list];
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:Tag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = Tag.theme_name;
    
    NSString *subNumber = nil;
    if(Tag.sub_number < 10000){
        subNumber = [NSString stringWithFormat:@"%zd人订阅",Tag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",Tag.sub_number / 10000.0];
    }
    self.subNameLabel.text = subNumber;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
