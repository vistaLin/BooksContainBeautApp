//
//  LXKColletedVC.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/14.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKColletedVC.h"
#import "LXKDbHelper.h"
#import "LXKWeiXinModel.h"
#import "LXKWebViewController.h"

@interface LXKColletedVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    
    BOOL _isEditing;
}

@property (nonatomic, copy) NSString *url;

@end

@implementation LXKColletedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self createTableView];
}

#pragma mark -- createTableView

- (void)createTableView
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:192 / 255.0 green:118 / 255.0 blue:31 / 255.0 alpha:1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_tableView.bounds];
    imageView.image = [UIImage imageNamed:@"backImage"];
    _tableView.backgroundView = imageView;
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"placeHolderImage"]];
    // 去掉cell的边线
    _tableView.separatorColor = [UIColor clearColor];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self loadData];
}

#pragma mark -- data

// 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadData
{
    [self dataArray];
    // 记得要移除数据 不然视图会再次添加一个视图
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[[LXKDbHelper helper] getAllCollects]];
    [_tableView reloadData];
}

#pragma mark -- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
    }
    cell.backgroundColor = [UIColor clearColor];
    LXKWeiXinModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.ctime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXKWeiXinModel *model = [[LXKWeiXinModel alloc] init];
    model = _dataArray[indexPath.row];
    
    LXKWebViewController *webVC = [[LXKWebViewController alloc] init];
    webVC.model = model;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果点击了删除 就先删除数据库 在删除模型 最后刷新视图
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LXKWeiXinModel *model = _dataArray[indexPath.row];
        if ([[LXKDbHelper helper] removeFromCollect:model.url]) {
            [_dataArray removeObject:model];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            NSLog(@"删除失败");
        }
    }
}


@end
