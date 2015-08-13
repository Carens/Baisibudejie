//
//  LJLTagButton.m
//  项目
//
//  Created by LiJiale on 15/8/13.
//
//

#import "LJLTagButton.h"

@implementation LJLTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = LJLRGBColor(74, 139, 209);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * LJLTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = LJLTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LJLTagMargin;
}

@end
