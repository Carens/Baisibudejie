//
//  LJLCommentHeaderView.h
//  项目
//
//  Created by LiJiale on 15/8/4.
//
//

#import <UIKit/UIKit.h>

@interface LJLCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic,strong) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
