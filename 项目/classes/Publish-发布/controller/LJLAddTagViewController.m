//
//  LJLAddTagViewController.m
//  项目
//
//  Created by LiJiale on 15/8/13.
//
//

#import "LJLAddTagViewController.h"

@interface LJLAddTagViewController ()

@property (nonatomic,weak) UIView *contentView;

@property (nonatomic,weak) UITextField *textField;

@property (nonatomic,weak) UIButton *addButton;

@end

@implementation LJLAddTagViewController

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
    
}
@end
