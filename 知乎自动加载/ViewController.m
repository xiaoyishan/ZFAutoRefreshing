//
//  ViewController.m
//  知乎自动加载
//
//  Created by Sundear on 2017/7/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"

float OFFHeight = 500;

@interface ViewController (){
    __weak IBOutlet UITableView *Table;
    NSMutableArray *List;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    List = [NSMutableArray new];
    [self AddData];

    OFFHeight = Table.rowHeight * 7; //设置没差7个cell的高度时再次加载

    Table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(AddData)];
}

#pragma mark ---------UITableView----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return List.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(!cell)cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.textLabel.textAlignment = 1;

    return cell;
}



//加载时机

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ArcHeight = scrollView.mj_contentH - scrollView.mj_h;
    if (scrollView.mj_offsetY > ArcHeight - OFFHeight) {

        if (![Table.mj_footer isRefreshing]) {
            [Table.mj_footer beginRefreshing];
            NSLog(@"开始加载 页码：%zd", List.count/10);
        }
    }
}

//上拉加载更多数据
-(void)AddData{
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( .25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [List addObjectsFromArray:@[@1,@2,@3,@1,@2,@3,@1,@2,@3,@0]];
        [Table.mj_footer endRefreshing];
        [Table reloadData];
    //});
}




@end
