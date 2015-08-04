//
//  LJLTopWindow.m
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import "LJLTopWindow.h"

@implementation LJLTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LJLScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}
+ (void)show
{
    window_.hidden = NO;
}

+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {

        
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
