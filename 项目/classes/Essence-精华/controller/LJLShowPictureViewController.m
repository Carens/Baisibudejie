//
//  LJLShowPictureViewController.m
//  项目
//
//  Created by LiJiale on 15/8/1.
//
//

#import "LJLShowPictureViewController.h"
#import "LJLTopic.h"
#import <UIImageView+WebCache.h>
#import "LJLProgressView.h"

@interface LJLShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 图片 */
@property (nonatomic,strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet LJLProgressView *progressView;

@end

@implementation LJLShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = screenW;
    
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);

    } else {
        
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
- (IBAction)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
