//
//  LJLAddTagViewController.m
//  项目
//
//  Created by LiJiale on 15/8/13.
//
//

#import "LJLAddTagViewController.h"
#import "LJLTagButton.h"

@interface LJLAddTagViewController ()

@property (nonatomic,weak) UIView *contentView;

@property (nonatomic,weak) UITextField *textField;

@property (nonatomic,weak) UIButton *addButton;

/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation LJLAddTagViewController

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

//懒加载
- (UIButton *)addButton
{
    if(!_addButton){
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, LJLTopicCellMargin, 0, LJLTopicCellMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = LJLRGBColor(74, 139, 209);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
    
    
}
/**
 *  设置textFiled
 */
- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.width = LJLScreenW;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

//设置内容控件
- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = LJLTopicCellMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + LJLTopicCellMargin;
    contentView.height = LJLScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

//设置导航栏
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

#pragma mark - 监听方法
//监听导航右边按钮点击
- (void)done
{
    
}

//监听文字改变
- (void)textDidChange{
    
    if(self.textField.hasText){
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + LJLTopicCellMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
    }else{
        self.addButton.hidden = YES;
    }
}

//监听添加按钮点击
- (void)addButtonClick
{
    
    // 添加一个"标签按钮"
    LJLTagButton *tagButton = [LJLTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    
    // 清空textField文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

/**
 * 标签按钮的点击
 */
- (void)tagButtonClick:(LJLTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}


/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    // 更新标签按钮的frame
    for (int i = 0; i<self.tagButtons.count; i++) {
        LJLTagButton *tagButton = self.tagButtons[i];
        
        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { // 其他标签按钮
            LJLTagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LJLTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + LJLTagMargin;
            }
        }
    }
    
    // 最后一个标签按钮
    LJLTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LJLTagMargin;
    
    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + LJLTagMargin;
    }
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}



@end
