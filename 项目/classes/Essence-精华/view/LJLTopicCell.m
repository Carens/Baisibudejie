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
#import "LJLTopicPictureView.h"

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
//sinaV
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
//文字
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
//帖子中间的pictureView
@property (nonatomic,weak) LJLTopicPictureView *pictureView;

@end

@implementation LJLTopicCell

- (LJLTopicPictureView *)pictureView
{
    if(!_pictureView){
        LJLTopicPictureView *pictureView = [LJLTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(LJLTopic *)topic
{
    self.sinaVView.hidden = !topic.isSina_v;
    _topic = topic;
    //设置其他控件
    //图片
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.text_Label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholed:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholed:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholed:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholed:@"评论"];
    
    //根据模型类型(帖子类型)添加对应的内容到cell的中间
    if(topic.type == LJLTopicTypePicture){//图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (topic.type == LJLTopicTypeVoice) { // 声音帖子
        //        self.voiceView.topic = topic;
        //        self.voiceView.frame = topic.voiceF;
    }
    
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

- (void)setFrame:(CGRect)frame{
    frame.origin.x = LJLTopicCellMargin;
    frame.size.width -= 2 * LJLTopicCellMargin;
    frame.origin.y += LJLTopicCellMargin;
    frame.size.height -= LJLTopicCellMargin;
    [super setFrame:frame];
}
@end
