//
//  LJLPlaceholderTextView.m
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import "LJLPlaceholderTextView.h"

@interface LJLPlaceholderTextView ()

//占位文字label
@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation LJLPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if(!_placeholderLabel){
        
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:15];
        
        self.placeholderColor = [UIColor grayColor];
        
        [LJLNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [LJLNoteCenter removeObserver:self];
}

/**
 * 更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(LJLScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//    self.placeholderLabel.backgroundColor = [UIColor redColor];
    
}

#pragma mark - 重写setter

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    [self updatePlaceholderLabelSize];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
@end
