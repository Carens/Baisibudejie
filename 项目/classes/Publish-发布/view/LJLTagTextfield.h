//
//  LJLTagTextfield.h
//  项目
//
//  Created by LiJiale on 15/8/14.
//
//

#import <UIKit/UIKit.h>

@interface LJLTagTextfield : UITextField

/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();

@end
