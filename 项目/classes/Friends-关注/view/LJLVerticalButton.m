//
//  LJLVerticalButton.m
//  项目
//
//  Created by LiJiale on 15/7/26.
//
//

#import "LJLVerticalButton.h"

@implementation LJLVerticalButton

//设置按钮文字居中
- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setUp];
        
    };
    
    return self;
}
- (void)awakeFromNib
{
    [self setUp];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //设置label
    self.titleLabel.x = 0;
    self.titleLabel.y = self.width;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
}

@end
