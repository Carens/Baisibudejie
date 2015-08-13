//
//  LJLPlaceholderTextView.h
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import <UIKit/UIKit.h>

@interface LJLPlaceholderTextView : UITextView

/** 占位字 */
@property (nonatomic,copy) NSString *placeholder;

/** 占位字体颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;
@end
