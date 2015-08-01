//
//  LJLTopicPictureView.h
//  项目
//
//  Created by LiJiale on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@class LJLTopic;

@interface LJLTopicPictureView : UIView

/** topic模型 */
@property (nonatomic,strong) LJLTopic *topic;

+ (instancetype)pictureView;

@end
