//
//  LXKVideoViewController.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/22.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKVideoViewController.h"

#import "LXKVideoModel.h"
#import "LXKPlayViewController.h"
#import "LXKVideoTableViewCell.h"
#import "LXKPlayViewController.h"

@interface LXKVideoViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LXKVideoViewController
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
    NSUInteger num;
    NSString *videoUrl;
    AFHTTPSessionManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

#pragma mark -- createTableView

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData:YES];
    }];
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
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

- (void)loadData:(BOOL)refresh
{
    if (refresh) {
        num = 0;
        videoUrl = API_VIDEO_FIRST;
    } else {
        num += 10;
        videoUrl = [NSString stringWithFormat:API_VIDEO,num];
    }
    _manager = [AFHTTPSessionManager articleManager];
    [_manager
     GET:videoUrl
     parameters:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         if (refresh) {
             [_dataArray removeAllObjects];
         }
         // 注意要去的对象是一个什么类型的 不能循环字典叠加
         for (NSDictionary *dict in responseObject[@"itemList"]) {
             LXKVideoModel *model = [LXKVideoModel new];
             model = [LXKVideoModel yy_modelWithDictionary:dict[@"data"]];
             // 懒加载要用self来调用
             [self.dataArray addObject:model];
         }
         [_tableView reloadData];
         [self endRefresh];
         if (refresh) {
             MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                 [self loadData:NO];
             }];
             _tableView.mj_footer = footer;
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         if (num > 0) {
             num -= 10;
         }
         [self endRefresh];
         [SVProgressHUD showErrorWithStatus:@"刷新失败"];
     }];
}

- (void)endRefresh
{
    if (_tableView.mj_header.isRefreshing) {
        [_tableView.mj_header endRefreshing];
    }
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
    
}

#pragma mark -- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELLID = @"cellID";
    LXKVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[LXKVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    LXKVideoModel *model = _dataArray[indexPath.row];
    cell.imgName = model.cover.detail;
    [cell scrollImageInTableView:_tableView inView:self.view];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width * 0.62;
}

// 滑动视图滑动的时候的回调方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *cells = [_tableView visibleCells];
    for (LXKVideoTableViewCell *cell in cells) {
        [cell scrollImageInTableView:_tableView inView:self.view];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXKVideoModel *model = _dataArray[indexPath.row];
    LXKPlayViewController *playVC = [LXKPlayViewController new];
    playVC.model = model;
    [self.navigationController pushViewController:playVC animated:YES];
}

@end
