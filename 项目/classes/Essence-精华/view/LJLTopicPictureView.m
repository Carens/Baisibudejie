//
//  LJLTopicPictureView.m
//  项目
//
//  Created by LiJiale on 15/7/31.
//
//

#import "LJLTopicPictureView.h"
#import "LJLTopic.h"
#import <UIImageView+WebCache.h>
#import "LJLProgressView.h"
#import "LJLShowPictureViewController.h"

@interface LJLTopicPictureView ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//gif
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//点击查看全图按钮
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
//进度控件
@property (weak, nonatomic) IBOutlet LJLProgressView *progressView;

@end

@implementation LJLTopicPictureView

//创建一个类方法供外部使用
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//取消控件的自动布局
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
     //给图片添加监听器
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
    //立马显示下载进度
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //计算下载进度
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if(topic.isBigPicture == NO) return;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭图形上下文
        UIGraphicsEndImageContext();

    }];
    //判断是不是gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if(topic.isBigPicture){
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
