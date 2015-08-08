//
//  LJLMeFootView.m
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import "LJLMeFootView.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "LJLSquare.h"
#import "LJLSquareButton.h"
#import "LJLWebViewController.h"

@implementation LJLMeFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    if(self = [super initWithFrame:frame]){
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSArray *squares = [LJLSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
 
        
    }
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = LJLScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<squares.count; i++) {
        // 创建按钮
        LJLSquareButton *button = [LJLSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = squares[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];

    
}

- (void)buttonClick:(LJLSquareButton *)button
{
    if(![button.square.url hasPrefix:@"http"]) return;
    
    LJLWebViewController *web = [[LJLWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //取出当前的导航控制器
    UITabBarController *tabVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabVC.selectedViewController;
    
    [nav pushViewController:web animated:YES];
}

@end
