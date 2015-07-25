//
//  LJLRecommendUserCell.m
//  项目
//
//  Created by LiJiale on 15/7/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLRecommendUserCell.h"
#import <UIImageView+WebCache.h>
#import "LJLRecommendUser.h"

@interface  LJLRecommendUserCell()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
//粉丝数
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation LJLRecommendUserCell

- (void)setUser:(LJLRecommendUser *)user
{
    _user = user;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.screenNameLabel.text = user.screen_name;
    
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd万人关注",user.fans_count / 10000.0];
}

@end
