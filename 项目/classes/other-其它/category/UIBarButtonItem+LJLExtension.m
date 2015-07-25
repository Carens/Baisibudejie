//
//  UIBarButtonItem+LJLExtension.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIBarButtonItem+LJLExtension.h"

@implementation UIBarButtonItem (LJLExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    Button.size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[self alloc] initWithCustomView:Button];
}
@end
