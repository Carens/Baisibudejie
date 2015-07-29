//
//  LJLEssenceViewController.m
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLEssenceViewController.h"
#import "LJLRecommendTagsViewController.h"
#import "LJLAllViewController.h"
#import "LJLVideoViewController.h"
#import "LJLVoiceViewController.h"
#import "LJLPictureViewController.h"
#import "LJLWordViewController.h"


@interface LJLEssenceViewController () <UIScrollViewDelegate>

//底部红色标签
@property (nonatomic,weak) UIView *indicatorView;
//选中的按钮
@property (nonatomic,weak) UIButton *selectedButton;
//标签栏
@property (nonatomic,weak) UIView *titlesView;
//底部scrollview
@property (nonatomic,weak) UIScrollView *contentView;


@end

@implementation LJLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置导航栏
    [self setupNavigation];
    
    //添加所有子控制器
    [self setupAllChildViewControllers];
    
    //设置标签栏
    [self setupTitlesView];
    
    //设置底部scrollView
    [self setupContentView];
    
    
}

- (void)setupAllChildViewControllers
{
    
    LJLAllViewController *all = [[LJLAllViewController alloc] init];
    [self addChildViewController:all];
    
    LJLVideoViewController *video = [[LJLVideoViewController alloc] init];
    [self addChildViewController:video];
    
    LJLVoiceViewController *voice = [[LJLVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    LJLPictureViewController *picture = [[LJLPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    LJLWordViewController *word = [[LJLWordViewController alloc] init];
    [self addChildViewController:word];
    
}

//设置标签栏
- (void)setupTitlesView
{
    //添加标签
    UIView *titlesView = [[UIView alloc] init];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    
    
    //在标签中添加按钮
    NSArray *titles = @[@"全部全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat width = self.view.width / titles.count;
    CGFloat height = titlesView.height;
    
    for(NSInteger i = 0; i < titles.count; i++){
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.tag = i;
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
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
        
    }
    [titlesView addSubview:indicatorView];

}

//按钮监听方法
- (void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    LJLLog(@"------");
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

//设置底部scrollView
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
//    contentView.backgroundColor = [UIColor blackColor];
    contentView.delegate =self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * contentView.width, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
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

#pragma mark- 代码方法
//滑动结束
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    NSLog(@"%@",vc);
    vc.view.x = scrollView.contentOffset.x;
    // 设置控制器view的y值为0(默认是20)
    vc.view.y = 0;
    // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    
    //设置tableview的内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
}


//添加滑动手势滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}




@end
