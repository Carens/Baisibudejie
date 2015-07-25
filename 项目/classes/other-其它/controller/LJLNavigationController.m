//
//  LJLNavigationController.m
//  项目
//
//  Created by LiJiale on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLNavigationController.h"

@implementation LJLNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否是子控制器,如果不是子控制器进入
    if(self.childViewControllers.count > 0){
        
        //自定义按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让按钮的内容往左偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
