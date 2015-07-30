//
//  NSData+LJLExtension.h
//  项目
//
//  Created by LiJiale on 15/7/30.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (LJLExtension)

/**
 * 比较from和self的时间差值
 */
//返回一个日历类格式化的对比时间
- (NSDateComponents *)deltaFrom:(NSDate *)from;

//是否是今年
- (BOOL)isThisYear;

//是否是今天
- (BOOL)isThisToday;

//是否是昨天
- (BOOL)isYesterday;

@end
