//
//  LJLCommentCell.h
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import <UIKit/UIKit.h>

@class LJLComment;

@interface LJLCommentCell : UITableViewCell

/** 评论模型 */
@property (nonatomic,strong) LJLComment *comment;

@end
