//
//  LJLTabBar.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLTabBar.h"

@interface LJLTabBar()

//发布按钮
@property (nonatomic,weak) UIButton *publishButton;

@end
@implementation LJLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]){
    //添加发布按钮
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
    [self addSubview:publishButton];
    self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for(UIView *button in self.subviews)
    {
        if(![button isKindOfClass:[UIControl class]] || button == self.publishButton)continue;
        
        //计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1) ? index + 1 : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

@end
