//
//  LJLRecommendCategory.h
//  项目
//
//  Created by LiJiale on 15/7/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJLRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;



/** 右边的数据 */
@property (nonatomic,strong) NSMutableArray *users;

/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

/** 总数 */
@property (nonatomic,assign) NSInteger total;

@end
