//
//  LJLRecommendTag.h
//  项目
//
//  Created by LiJiale on 15/7/25.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJLRecommendTag : NSObject

/** 图片 */
@property (nonatomic,copy) NSString *image_list;

/** 名字 */
@property (nonatomic,copy) NSString *theme_name;

/** 订阅数 */
@property (nonatomic,assign) NSInteger sub_number;

@end
