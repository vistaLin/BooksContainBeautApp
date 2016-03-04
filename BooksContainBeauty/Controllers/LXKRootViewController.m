//
//  LXKRootViewController.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/24.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKRootViewController.h"
#import <YYModel.h>
#import <MJRefresh.h>
#import "LXKWeiXinModel.h"
#import "AFHTTPSessionManager+Util.h"
#import "LXKRootTableViewCell.h"

@interface LXKRootViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LXKRootViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    AFHTTPSessionManager *_manager;
    NSUInteger _currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

#pragma mark - createView

- (void) createTableView {
    
    self.title = @"颜如玉云";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataModel:YES];
    }];
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - data

- (void) loadDataModel:(BOOL) refresh {
   
    if (refresh) {
        _currentPage = kDefaultStartPage;
    }
    else {
        _currentPage += 1;
    }
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setObject:@(_currentPage) forKey:@"page"];
    NSString *urlStr = [NSString stringWithFormat:API_ARTCLE,_currentPage];
    
    _manager = [AFHTTPSessionManager articleManager];
    [_manager
              GET:urlStr
       parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObejct) {
              if(!_dataArray) {
                  _dataArray = [NSMutableArray array];
              }
              for (NSDictionary *objDict in responseObejct[@"newslist"]) {
                  LXKWeiXinModel *model = [LXKWeiXinModel yy_modelWithDictionary:objDict];
                  [_dataArray addObject:model];
              }
              // 必须要在解析数据成功后就刷新视图 否侧集合视图的委托方法都不会回调   因为单元格复用才调用协议的回调方法
             [_tableView reloadData];
             [self endRefreshing];
              
              if (refresh) {
                  MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                      [self loadDataModel:NO];
                  }];
                  _tableView.mj_footer = footer;
              }
          }
          failure:^(NSURLSessionDataTask * task, NSError *error) {
              NSLog(@"%@",error);
              if (_currentPage > 1) {
                  _currentPage -= 1;
                  [self endRefreshing];
              }
          }
     ];
    // 因为是异步请求？所以程序会在数据没有解析完成就会显示单元格 会走这里？
    NSLog(@"%@",_dataArray);
}

- (void) endRefreshing {
    if (_tableView.mj_header.isRefreshing) {
        [_tableView.mj_header endRefreshing];
    }
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LXKRootTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[LXKRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
   
    LXKWeiXinModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

@end
