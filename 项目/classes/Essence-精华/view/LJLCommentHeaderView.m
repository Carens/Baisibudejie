//
//  LJLCommentHeaderView.m
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import "LJLCommentHeaderView.h"

@interface LJLCommentHeaderView ()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation LJLCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LJLCommentHeaderView *header = [tableView dequeueReusableCellWithIdentifier:ID];
    if(header == nil){
        header = [[LJLCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = LJLGlobalBg;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LJLRGBColor(67, 67, 67);
        label.width = 200;
        label.x = LJLTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;

        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = _title;
}
@end
