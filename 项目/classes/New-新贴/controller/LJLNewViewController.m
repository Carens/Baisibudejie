//
//  LJLNewViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLNewViewController.h"

@interface LJLNewViewController ()

@end

@implementation LJLNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    self.navigationItem.leftBarButtonItem =     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = LJLGlobalBg;
}

- (void)tagClick
{
    LJLLogFunc;
}

@end
