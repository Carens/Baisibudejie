//
//  LJLAddTagToolbar.m
//  项目
//
//  Created by LiJiale on 15/8/12.
//
//

#import "LJLAddTagToolbar.h"
#import "LJLAddTagViewController.h"

@interface LJLAddTagToolbar ()
//顶部控件
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation LJLAddTagToolbar

- (void)awakeFromNib
{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = LJLTopicCellMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    LJLAddTagViewController *addTagVC = [[LJLAddTagViewController alloc] init];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    
    [nav pushViewController:addTagVC animated:YES];
}

@end
