//
//  LJLTopicCell.h
//  项目
//
//  Created by LiJiale on 15/7/29.
//
//

#import <UIKit/UIKit.h>

@class LJLTopic;

@interface LJLTopicCell : UITableViewCell

/** 段子模型 */
@property (nonatomic,strong) LJLTopic *topic;

+ (instancetype)cell;

@end
