//
//  LJLPushGuideView.m
//  项目
//
//  Created by LiJiale on 15/7/27.
//
//

#import "LJLPushGuideView.h"

@implementation LJLPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙漏文件中版本号
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if(![currentVersion isEqualToString:oldVersion]){
        //获得当前窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //添加推送通知
        LJLPushGuideView *pushGuideView = [LJLPushGuideView pushGuide];
        pushGuideView.frame = window.bounds;
        
        [window addSubview:pushGuideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)pushGuide
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
