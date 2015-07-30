//
//  LJLTopic.m
//  项目
//
//  Created by LiJiale on 15/7/29.
//
//

#import "LJLTopic.h"

@implementation LJLTopic

//重写创建时间的get方法
- (NSString *)create_time
{
    //创建时间格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    //判断帖子创建的时间
    if(create.isThisYear){
        if(create.isThisToday){
            //相隔时间
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];

        if (cmps.hour >= 1) { // 时间差距 >= 1小时
            return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
        } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
            return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
        } else { // 1分钟 > 时间差距
            return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
}

}

@end
