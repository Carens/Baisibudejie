//
//  LJLSqaureButton.m
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import "LJLSquareButton.h"
#import "LJLSquare.h"
#import <UIButton+WebCache.h>



@implementation LJLSquareButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //按钮图片
    
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    //按钮文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

//重写模型

- (void)setSquare:(LJLSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}


@end
