//
//  LJLTopic.h
//  项目
//
//  Created by LiJiale on 15/7/29.
//
//

#import <Foundation/Foundation.h>

@interface LJLTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
//新浪加V
@property (nonatomic,assign,getter = isSina_v) BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) LJLTopicType type;


/****** 额外的辅助属性 ******/

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign, readonly) CGRect pictureF;
//是否是大图
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
//下载进度条
@property (nonatomic,assign) CGFloat pictureProgress;

@end
