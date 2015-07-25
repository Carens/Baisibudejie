//
//  UIBarButtonItem+LJLExtension.h
//  项目
//
//  Created by LiJiale on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LJLExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
