//
//  LJLMeViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLMeViewController.h"
#import "LJLMeCell.h"
#import "LJLMeFootView.h"

@interface LJLMeViewController ()

@end

static NSString *LJLMeID = @"me";
@implementation LJLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
}
- (void)setupTableView
{
    //背景色
    self.tableView.backgroundColor = LJLGlobalBg;
    //分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册
    [self.tableView registerClass:[LJLMeCell class] forCellReuseIdentifier:LJLMeID];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LJLTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake( -25, 0, 0, 0);
    
    self.tableView.tableFooterView = [[LJLMeFootView alloc] init];
}

- (void)setupNav
{
    self.navigationItem.title = @"我的";
    
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)],
        [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)]
                                                ];
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

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLMeID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
