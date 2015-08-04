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
#import "LJLCommentHeaderView.h"
#import "LJLCommentCell.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>

static NSString * const LJLCommentId = @"comment";

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
@property (nonatomic, strong) LJLComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LJLCommentViewController

- (AFHTTPSessionManager *)manager
{
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


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
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
}
//加载更多数据
- (void)loadMoreComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    LJLComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *newArray = [LJLComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newArray];
        
        self.page = page;
        
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if(self.latestComments.count >= total){
            self.tableView.footer.hidden = YES;
        }else{
            [self.tableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
    
}
- (void)loadNewComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
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
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}
- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
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
    
    //添加监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //设置CommentCell的高度
    //估计高度
    self.tableView.estimatedRowHeight = 44;
    //自动计算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //背景颜色
    self.tableView.backgroundColor = LJLGlobalBg;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJLCommentCell class]) bundle:nil] forCellReuseIdentifier:LJLCommentId];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LJLTopicCellMargin, 0);
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
    if (self.topic.top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
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
    
    // 隐藏尾部控件
    tableView.footer.hidden = (latestCount == 0);
    
    if(section == 0){
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //先从缓冲池中找
    LJLCommentHeaderView *header = [LJLCommentHeaderView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLCommentId];
       cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}


@end
