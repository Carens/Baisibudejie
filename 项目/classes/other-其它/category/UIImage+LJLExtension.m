//
//  UIImage+LJLExtension.m
//  项目
//
//  Created by LiJiale on 15/8/7.
//
//

#import "UIImage+LJLExtension.h"

@implementation UIImage (LJLExtension)

- (UIImage *)circleImage
{
    //开启图形上下文,NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个源
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
