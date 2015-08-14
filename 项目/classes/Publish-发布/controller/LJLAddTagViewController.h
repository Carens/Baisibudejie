//
//  LJLAddTagViewController.h
//  项目
//
//  Created by LiJiale on 15/8/13.
//
//

#import <UIKit/UIKit.h>

@interface LJLAddTagViewController : UIViewController

/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;

@end
