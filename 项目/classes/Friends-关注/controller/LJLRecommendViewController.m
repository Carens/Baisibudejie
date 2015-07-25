//
//  LJLRecommendViewController.m
//  项目
//
//  Created by LiJiale on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

//存在的问题

/**
 1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */
#import "LJLRecommendViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LJLRecommendCategory.h"
#import "LJLRecommendCategoryCell.h"
#import "LJLRecommendUserCell.h"
#import "LJLRecommendUser.h"
#import <MJRefresh.h>

#define LJLSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LJLRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

//左边的数据
/** 左边数据数组 */
@property (nonatomic,strong) NSArray *categories;

//左边的类别表格
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右边的类别表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation LJLRecommendViewController


static NSString * const LJLCategoryId = @"category";
static NSString * const LJLUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setUpTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *parametes = [NSMutableDictionary dictionary];
    parametes[@"a"] = @"category";
    parametes[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parametes success:^(NSURLSessionDataTask *task, id responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        //返回的json数据 字典转模型
        self.categories = [LJLRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
//        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //显示加载失败
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)setUpTableView
{
    //category注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"LJLRecommendCategoryCell" bundle:nil] forCellReuseIdentifier:LJLCategoryId];
    //user注册
    [self.userTableView registerNib:[UINib nibWithNibName:@"LJLRecommendUserCell" bundle:nil] forCellReuseIdentifier:LJLUserId];
    
    //设置tableView的inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置导航栏标题
    self.navigationItem.title = @"推荐关注";
    //设置控制器view的背景颜色
    self.view.backgroundColor = LJLGlobalBg;
    
}

//添加刷新控件
- (void)setupRefresh
{
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
//    self.userTableView.footer.hidden = YES;
    
}

- (void)loadMoreUsers
{
    LJLRecommendCategory *category = LJLSelectedCategory;
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //字典数组转模型数组
        NSArray *array = [LJLRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //将解析的数据拼接到当前的数组中
        [category.users addObjectsFromArray:array];
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //判断当前数据是否全部加载完成
        if(category.users.count == category.total){//全部加载完毕
            [self.userTableView.footer noticeNoMoreData];
        }else{
            [self.userTableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        LJLLog(@"%@",error);
    }];
    
    
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边的表格数据
    if(tableView == self.categoryTableView){
        return self.categories.count;
    }else
    {//右边的表格数据
//        LJLRecommendCategory *c = LJLSelectedCategory;
//        
//        return c.users.count;
        NSInteger count = [LJLSelectedCategory users].count;
        
        //根据右边数据有无判断是否隐藏
        self.userTableView.footer.hidden = (count==0);
        
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.categoryTableView){//左边的cell
        LJLRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{//右边的cell
        LJLRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLUserId];
        cell.user = [LJLSelectedCategory users][indexPath.row];
        
        return cell;

    }

}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJLRecommendCategory *c = self.categories[indexPath.row];
    
    if(c.users.count){
        [self.userTableView reloadData];
    }else{
        //立即刷新当前页,赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        //设置当前页码
        c.currentPage = 1;
        
        //发送请求
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        params[@"page"] = @(c.currentPage);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

            // 字典数组 -> 模型数组
            NSArray *array = [LJLRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //易错点  误把数组当模型添加 addobject:array
            [c.users addObjectsFromArray:array];
            
            c.total = [responseObject[@"total"] integerValue];
            
            //刷新右边表格
            [self.userTableView reloadData];
            
            if(c.total == c.users.count){//全部加载完毕
                [self.userTableView.footer noticeNoMoreData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            LJLLog(@"%@",error);
        }];
    }
}
@end
