//
//  LJLVoiceView.m
//  项目
//
//  Created by LiJiale on 15/8/2.
//
//

#import "LJLVoiceView.h"
#import "LJLTopic.h"
#import <UIImageView+WebCache.h>
#import "LJLShowPictureViewController.h"

@interface LJLVoiceView()

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
//播放时长
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;


@end

@implementation LJLVoiceView

+ (instancetype)voice
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    LJLShowPictureViewController *showPicture = [[LJLShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
- (void)setTopic:(LJLTopic *)topic
{
    _topic = topic;
    //设置背景图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //设置播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}
@end
