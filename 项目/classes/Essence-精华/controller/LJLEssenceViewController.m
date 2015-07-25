//
//  LJLEssenceViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLEssenceViewController.h"
#import "LJLRecommendTagsViewController.h"

@interface LJLEssenceViewController ()

@end

@implementation LJLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = LJLGlobalBg;
}

- (void)tagClick
{
    LJLRecommendTagsViewController *tags = [[LJLRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:tags animated:YES];
}




@end
