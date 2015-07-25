//
//  LJLMeViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLMeViewController.h"

@interface LJLMeViewController ()

@end

@implementation LJLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)],
        [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)]
    ];
    self.view.backgroundColor = LJLGlobalBg;
}

//setting监听方法
- (void)settingClick
{
    LJLLogFunc;
}

//moon监听方法
- (void)moonClick
{
    LJLLogFunc;
}

@end
