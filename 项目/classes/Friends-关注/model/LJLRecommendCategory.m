//
//  LJLRecommendCategory.m
//  项目
//
//  Created by LiJiale on 15/7/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLRecommendCategory.h"

@implementation LJLRecommendCategory

- (NSMutableArray *)users
{
    if(!_users){
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
