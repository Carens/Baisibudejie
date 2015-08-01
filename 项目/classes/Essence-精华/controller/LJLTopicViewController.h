//
//  LJLTopicViewController.h
//  项目
//
//  Created by LiJiale on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface LJLTopicViewController : UITableViewController

/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) LJLTopicType type;

@end
