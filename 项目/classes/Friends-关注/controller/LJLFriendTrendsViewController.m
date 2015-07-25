//
//  LJLFriendTrendsViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLFriendTrendsViewController.h"
#import "LJLRecommendViewController.h"

@interface LJLFriendTrendsViewController ()

@end

@implementation LJLFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    self.view.backgroundColor = LJLGlobalBg;
}

- (void)friendsClick
{
    
    LJLRecommendViewController *recommendVc = [[LJLRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVc animated:YES];
}

@end
