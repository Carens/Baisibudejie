//
//  LJLTopicCell.m
//  项目
//
//  Created by LiJiale on 15/7/29.
//
//

#import "LJLTopicCell.h"
#import <UIImageView+WebCache.h>
#import "LJLTopic.h"

@interface LJLTopicCell ()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
//分享
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation LJLTopicCell

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(LJLTopic *)topic
{
    _topic = topic;
    
    //设置其他控件
    //图片
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholed:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholed:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholed:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholed:@"评论"];
    
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholed:(NSString *)placeholed
{
    if(count > 10000){
        placeholed = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }else if(count > 0){
        placeholed = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholed forState:UIControlStateNormal];
}

@end
