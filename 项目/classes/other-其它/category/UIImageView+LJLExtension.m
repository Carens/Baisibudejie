//
//  UIImageView+LJLExtension.m
//  项目
//
//  Created by LiJiale on 15/8/7.
//
//

#import "UIImageView+LJLExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LJLExtension)

- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

@end
