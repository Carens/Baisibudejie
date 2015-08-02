//
//  LJLVideoView.h
//  项目
//
//  Created by LiJiale on 15/8/2.
//
//

#import <UIKit/UIKit.h>

@class LJLTopic;

@interface LJLVideoView : UIView

/** topic模型*/
@property (nonatomic,strong) LJLTopic *topic;

+ (instancetype)video;

@end
