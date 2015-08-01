//
//  LJLPublishView.m
//  项目
//
//  Created by LiJiale on 15/8/1.
//
//

#import "LJLPublishView.h"
#import "LJLVerticalButton.h"
#import <POP.h>

#define LJLRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

static CGFloat const LJLAnimationDelay = 0.1;
static CGFloat const LJLSpringFactor = 10;
@implementation LJLPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    LJLPublishView *publishView = [LJLPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib {
    // 不能被点击
    LJLRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LJLScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (LJLScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        LJLVerticalButton *button = [[LJLVerticalButton alloc] init];
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - LJLScreenH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = LJLSpringFactor;
        anim.springSpeed = LJLSpringFactor;
        anim.beginTime = CACurrentMediaTime() + LJLAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = LJLScreenW * 0.5;
    CGFloat centerEndY = LJLScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - LJLScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * LJLAnimationDelay;
    anim.springBounciness = LJLSpringFactor;
    anim.springSpeed = LJLSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        LJLRootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button
{
    
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            LJLLog(@"发视频");
        } else if (button.tag == 1) {
            LJLLog(@"发图片");
        }
    }];
}

- (IBAction)cancel{
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    
    // 不能被点击
    LJLRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + LJLScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * LJLAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                LJLRootView.userInteractionEnabled = YES;
                
//                [self removeFromSuperview];
                window_ = nil;
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}


@end
