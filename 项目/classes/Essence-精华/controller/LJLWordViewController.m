//
//  LJLWordViewController.m
//  项目
//
//  Created by LiJiale on 15/7/28.
//
//

#import "LJLWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>

#import "LJLTopic.h"
#import "LJLTopicCell.h"

@interface LJLWordViewController ()

//帖子数据
@property (nonatomic,strong) NSMutableArray *topics;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic,strong) NSString *maxtime;
//当前的页码
@property (nonatomic,assign) NSInteger page;
//最后一次的请求
@property (nonatomic,strong) NSDictionary *params;

@end

@implementation LJLWordViewController

- (NSMutableArray *)topics
{
    if(_topics == nil){
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的内边距
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    
    
}
static NSString * const LJLTopicCellID = @"topic";
- (void)setupTableView
{
    //设置tableview的内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LJLTitilesViewH + LJLTitilesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJLTopicCell class]) bundle:nil] forCellReuseIdentifier:LJLTopicCellID];
}

- (void)setupRefresh
{
    //添加头部下拉刷新控件
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    //添加尾部上啦刷新控件
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

//加载新的数据
- (void)loadNewTopics
{
    //结束尾部刷新控件
    [self.tableView.footer endRefreshing];
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"  parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //如果返回的请求体不是当前的请求体就退出
        if(self.params != params) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [LJLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.header endRefreshing];
        
        //清空当前页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != params) return;
        
        //结束刷新
        [self.tableView.header endRefreshing];
    }];
    
    
}

- (void)loadMoreTopics
{
    //结束头部刷新
    [self.tableView.header endRefreshing];
    
    //设置页码
    self.page++;
    
    //设置请求体
    NSMutableDictionary  *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"  parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //判断当前请求体
        if(self.params != params )return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //解析返回的数据
        NSArray *topics = [LJLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //拼接数据
        [self.topics addObjectsFromArray:topics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新控件
        [self.tableView.footer endRefreshing];
        
        self.page = page;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != params) return;
        //结束刷新
        [self.tableView.footer endRefreshing];
    }];
    
}
#pragma mark - Table view data source
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

//cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LJLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLTopicCellID];
    
    cell.topic =self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
