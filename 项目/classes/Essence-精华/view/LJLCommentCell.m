//
//  LJLCommentCell.m
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import "LJLCommentCell.h"
#import "LJLComment.h"
#import <UIImageView+WebCache.h>
#import "LJLUser.h"

@interface LJLCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LJLCommentCell

//是否可以成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//系统自带的是否弹出
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}


- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(LJLComment *)comment
{
    _comment = comment;
    
    [self.profileImageView setHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:LJLUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LJLTopicCellMargin;
    frame.size.width -= 2 * LJLTopicCellMargin;
    
    
    [super setFrame:frame];
}

@end
