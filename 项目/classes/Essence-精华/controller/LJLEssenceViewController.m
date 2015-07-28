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

//底部红色标签
@property (nonatomic,weak) UIView *indicatorView;

//选中的按钮
@property (nonatomic,weak) UIButton *selectedButton;

@end

@implementation LJLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置导航栏
    [self setupNavigation];
    
    //设置标签栏
    [self setupTitlesView];
}

//设置标签栏
- (void)setupTitlesView
{
    //添加标签
    UIView *titlesView = [[UIView alloc] init];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    titlesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titlesView];
    
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    
    //在标签中添加按钮
    NSArray *titles = @[@"全部全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat width = self.view.width / titles.count;
    CGFloat height = titlesView.height;
    
    for(NSInteger i = 0; i < titles.count; i++){
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //enable = NO;的状态
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        if(i == 0){
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
        
    }
    
    


}

//按钮监听方法
- (void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    LJLLog(@"------");
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}


- (void)setupNavigation
{
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
