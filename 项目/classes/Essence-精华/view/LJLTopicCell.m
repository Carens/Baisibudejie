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
#import "LJLVoiceView.h"
#import "LJLVideoView.h"
#import "LJLComment.h"
#import "LJLUser.h"

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
//帖子中间的voiceView
@property (nonatomic,weak) LJLVoiceView *voiceView;
//帖子中间的VideoView
@property (nonatomic,weak) LJLVideoView *videoView;
//最热评论控件
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
//评论内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@end

@implementation LJLTopicCell

- (LJLVideoView *)videoView
{
    if(!_videoView){
        LJLVideoView *videoView = [LJLVideoView video];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (LJLVoiceView *)voiceView
{
    if(!_voiceView){
       LJLVoiceView *voiceView = [LJLVoiceView voice];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (LJLTopicPictureView *)pictureView
{
    if(!_pictureView){
        LJLTopicPictureView *pictureView = [LJLTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
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
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.text_Label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholed:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholed:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholed:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholed:@"评论"];
    
    //根据模型类型(帖子类型)添加对应的内容到cell的中间
    if(topic.type == LJLTopicTypePicture){//图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == LJLTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(topic.type == LJLTopicTypeVideo){//视频帖子
        self.voiceView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else{//段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    
    
    if(topic.top_cmt){
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else{
        self.topCmtView.hidden = YES;
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

    frame.origin.y += LJLTopicCellMargin;
    frame.size.height -= LJLTopicCellMargin;
    [super setFrame:frame];
}
@end
