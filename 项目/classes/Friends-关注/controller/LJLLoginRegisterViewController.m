//
//  LJLLoginRegisterViewController.m
//  项目
//
//  Created by LiJiale on 15/7/26.
//
//

#import "LJLLoginRegisterViewController.h"

@interface LJLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftMargn;

@end

@implementation LJLLoginRegisterViewController
- (IBAction)registerButton:(UIButton *)button {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if(self.loginLeftMargn.constant == 0){
        self.loginLeftMargn.constant = -self.view.width;
        button.selected = YES;
    }else{
        self.loginLeftMargn.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}

//退出modal 
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
