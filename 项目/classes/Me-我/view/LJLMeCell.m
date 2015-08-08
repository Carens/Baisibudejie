//
//  LJLMeCell.m
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import "LJLMeCell.h"

@implementation LJLMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //设置cell样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //设置cell的背景
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.backgroundColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.centerY;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LJLTopicCellMargin;
}
@end
