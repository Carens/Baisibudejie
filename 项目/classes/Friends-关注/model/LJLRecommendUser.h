//
//  LJLRecommendUser.h
//  项目
//
//  Created by LiJiale on 15/7/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJLRecommendUser : NSObject

/** 头像 */
@property (nonatomic,copy) NSString *header;

/** 昵称 */
@property (nonatomic,copy) NSString *screen_name;

/** 粉丝数 */
@property (nonatomic,assign) NSInteger fans_count;

@end
