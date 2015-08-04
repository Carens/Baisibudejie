//
//  LJLCommentViewController.m
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import "LJLCommentViewController.h"
#import "LJLTopicCell.h"
#import "LJLTopic.h"
#import "LJLComment.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>



@interface LJLCommentViewController () <UITableViewDelegate,UITableViewDataSource>
//底部工具条约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
//评论内容
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子 */
@property (nonatomic, strong) NSArray *saved_top_cmt;

@end

@implementation LJLCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];

}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
}

- (void)loadNewComments
{
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.hotComments = [LJLComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [LJLComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //刷新数据
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}
- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topic.top_cmt.count) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    
    LJLTopicCell *cell = [LJLTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(LJLScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = self.topic.cellHeight + LJLTopicCellMargin;
    self.tableView.tableHeaderView = header;
}

//添加监听键盘通知
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = LJLGlobalBg;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = LJLScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)dealloc
{
    // 清空top_cmt
    if (self.topic.top_cmt.count) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (LJLComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDataSource>
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if(hotCount) return 2;
    if(latestCount) return 1;
    return 0;
}

//每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if(section == 0){
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    LJLComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    return cell;
}


@end
