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
#import "LXKWeiXinFrameModel.h"
#import "LXKWebViewController.h"
#import "HACursor.h"

@interface LXKRootViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, copy) NSMutableArray *pageMulViewsArray;

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
    
   
    [self addCursorView];
}

#pragma mark -- addCursorView
- (void)addCursorView
{
    self.title = @"颜如玉云";
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    _titlesArray = @[@"微文",@"国内",@"国际",@"时事",@"旅行",@"趣闻"];
   
    HACursor *cursor = [[HACursor alloc] init];
   
    cursor.frame = CGRectMake(0, 64, WIDTH, 45);
    cursor.titles = self.titlesArray;
    cursor.pageViews = [self createPageView];
    cursor.rootScrollViewHeight = HEIGHT - 109;
    
    cursor.titleNormalColor = [UIColor whiteColor];
    cursor.titleSelectedColor = [UIColor redColor];
    cursor.showSortbutton = NO;
    cursor.backgroundColor = [UIColor greenColor];
//    cursor.minFontSize = 10.0;
//    cursor.maxFontSize = 30.0;
    cursor.isGraduallyChangFont = NO;
    cursor.isGraduallyChangColor = YES;
    [self.view addSubview:cursor];
}

- (NSMutableArray *)createPageView {
    if (!_pageMulViewsArray) {
        _pageMulViewsArray = [NSMutableArray new];
    }
            for (int i = 0; i < _titlesArray.count; i++) {
                if (i == 0) {
                    [self createTableView];
                    [_pageMulViewsArray addObject:_tableView];
        } else {
            UIView  *view = [UIView new];
            view.backgroundColor = [UIColor redColor];
            [_pageMulViewsArray addObject:view];
        }
    }
    return _pageMulViewsArray;
}

#pragma mark - createView

- (void) createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    UIView *homeView = [UIView new];
//    homeView.backgroundColor = [UIColor redColor];
//  
//    [_pageMulViewsArray addObject:homeView];
  //  [_pageMulViewsArray addObject:_tableView];
  //  [self.view addSubview:_tableView];
   
   
    
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
                  LXKWeiXinFrameModel *model = [LXKWeiXinFrameModel new];
                  model.model = [LXKWeiXinModel yy_modelWithDictionary:objDict];
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
    
//    LXKRootTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CELL"];
//    if (!cell) {
//        cell = [[LXKRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
//    }
    LXKRootTableViewCell *cell = [LXKRootTableViewCell cellInTableView:tableView forIndexPath:indexPath];
    cell.frameModel = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXKWeiXinFrameModel *frameModel = _dataArray[indexPath.row];
    return frameModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXKWebViewController *webVC = [[LXKWebViewController alloc] init];
    LXKWeiXinFrameModel *model = _dataArray[indexPath.row];
    webVC.url = model.model.url;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
