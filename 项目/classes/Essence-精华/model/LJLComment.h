//
//  LJLComment.h
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import <Foundation/Foundation.h>

@class LJLUser;

@interface LJLComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LJLUser *user;

@end
