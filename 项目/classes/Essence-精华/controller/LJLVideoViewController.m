//
//  LJLVideoViewController.m
//  项目
//
//  Created by LiJiale on 15/7/28.
//
//

#import "LJLVideoViewController.h"

@interface LJLVideoViewController ()

@end

@implementation LJLVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


#pragma mark - Table view data source
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil){
        //此处错误多次  应为cell  不是UITableViewCell *cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor yellowColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd",[self class],indexPath.row];
    
    return cell;
}


@end
