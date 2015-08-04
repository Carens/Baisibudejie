//
//  LJLUser.h
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import <Foundation/Foundation.h>

@interface LJLUser : NSObject

/** 用户名 */
@property (nonatomic,copy) NSString *username;
/** 性别 */
@property (nonatomic,copy) NSString *sex;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;

@end
