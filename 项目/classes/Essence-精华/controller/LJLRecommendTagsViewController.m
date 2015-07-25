//
//  LJLRecommendTagsViewController.m
//  项目
//
//  Created by LiJiale on 15/7/25.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LJLRecommendTagsViewController.h"
#import "LJLRecommendTag.h"
#import "LJLRecommendTagCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>


@interface LJLRecommendTagsViewController ()

@property (nonatomic,strong) NSArray *tags;

@end

static NSString * const LJLTagsId = @"tag";

@implementation LJLRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化内部控件
    [self setupTableView];
    
    //加载数据
    [self loadTags];
}
- (void)loadTags
{
    //HUD
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //解析返回的json数据
        self.tags = [LJLRecommendTag objectArrayWithKeyValuesArray:responseObject];
        LJLLog(@"%@",self.tags);
        //刷新表格
        [self.tableView reloadData];
        
        //隐藏hud
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
    
}

- (void)setupTableView
{
    
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJLRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LJLTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LJLGlobalBg;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LJLLog(@"%zd",self.tags.count);
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LJLTagsId];
    cell.Tag = self.tags[indexPath.row];
    LJLLog(@"%@",cell);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
