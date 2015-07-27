//
//  LJLTextField.m
//  项目
//
//  Created by LiJiale on 15/7/27.
//
//

#import "LJLTextField.h"
#import <objc/runtime.h>

static NSString * const LJLplaceholder =  @"_placeholderLabel.textColor";
@implementation LJLTextField

+ (void)initialize
{
    [self getIvars];
}

- (void)awakeFromNib
{
    //修改光标颜色
    self.tintColor = self.textColor;
    //当前输入文本框失去焦点
    [self resignFirstResponder];
}

//通过 (Runtime)运行时获得_placeholderLabel.textColor
+ (void)getIvars
{
    unsigned int count = 0;
    //拷贝所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for(int i = 0;i < count; i++){
        //取出成员变量
//        Ivar ivar = ivars[i];
        
        //打印成员变量的名字
//        LJLLog(@"%s  %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
    
}

//当前文本框获得焦点时调用
- (BOOL)becomeFirstResponder
{
    //设置占位文字的颜色
    [self setValue:self.textColor forKeyPath:LJLplaceholder];
    return [super becomeFirstResponder];
    
}

//当前文本框失去焦点是调用
- (BOOL)resignFirstResponder
{
    //设置占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:LJLplaceholder];
    return [super resignFirstResponder];
}

@end
