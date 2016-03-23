//
//  LXKRootViewController.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/24.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#ifndef W_H_
#define W_H_
#define  WIDTH self.view.bounds.size.width
#define  HEIGHT self.view.bounds.size.height
#endif

#import "LXKRootViewController.h"
#import <YYModel.h>
#import <MJRefresh.h>
#import "HACursor.h"
#import <RESideMenu.h>

#import "LXKWeiXinModel.h"
#import "AFHTTPSessionManager+Util.h"
#import "LXKRootTableViewCell.h"
#import "LXKWeiXinFrameModel.h"
#import "LXKWebViewController.h"
#import "LXKColletedVC.h"


@interface LXKRootViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *pageMulViewsArray;
@property (nonatomic, copy) NSArray *urlArray;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LXKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCursorView];
}

#pragma mark -- addCursorView

- (void)addCursorView
{
//     必须要设置barTintColor的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:192 / 255.0 green:118 / 255.0 blue:31 / 255.0 alpha:1];
//    self.title = @"新闻";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 0, 0)];
    [self.view addSubview:view];
    
    _titlesArray = @[@"国内",@"国际",@"科技",@"体育",@"奇闻",@"旅游"];
    _urlArray = @[API_HOME,API_WORLD,API_SCIENCE,API_SPORTS,API_ANECDOTE,APT_TRAVEL];
   
    HACursor *cursor = [[HACursor alloc] init];
    cursor.frame = CGRectMake(0, 64, WIDTH, 45);
    cursor.titles = self.titlesArray;
    cursor.pageViews = [self createPageView];
    cursor.rootScrollViewHeight = HEIGHT - 109;
    cursor.titleNormalColor = [UIColor colorWithRed:63 / 255.0 green:35 / 255.0 blue:4 / 255.0  alpha:1];
    cursor.titleSelectedColor = [UIColor colorWithRed:249 / 255.0 green:64 / 255.0 blue:69 / 255.0  alpha:1];
    cursor.showSortbutton = NO;
    cursor.backgroundColor = [UIColor colorWithRed:191 / 255.0 green:107 / 255.0 blue:1 / 255.0 alpha:0.8];
//    cursor.minFontSize = 10.0;
//    cursor.maxFontSize = 30.0;
   
    cursor.isGraduallyChangFont = NO;
    cursor.isGraduallyChangColor = NO;
    [self.view addSubview:cursor];
    
    
}

- (void)leftBarButtonClicked:(UIBarButtonItem *) sender
{
    LXKColletedVC *collectVC = [LXKColletedVC new];
    [self.navigationController pushViewController:collectVC animated:YES];
    
}

- (NSMutableArray *)createPageView {
    if (!_pageMulViewsArray) {
        _pageMulViewsArray = [NSMutableArray new];
    }
    for (int i = 0; i < _titlesArray.count; i++) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadDataModel:YES index:tableView.tag];
        }];
        tableView.mj_header = header;
        [tableView.mj_header beginRefreshing];
        [_pageMulViewsArray addObject:tableView];
    }
    return _pageMulViewsArray;
}

- (void) endRefreshing:(UITableView *) tableView {
    if (tableView.mj_header.isRefreshing) {
        [tableView.mj_header endRefreshing];
    }
    if (tableView.mj_footer.isRefreshing) {
        [tableView.mj_footer endRefreshing];
    }
}

- (NSMutableArray *)pageArray
{
    if (!_pageArray) {
        _pageArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < 6; i++) {
            [_pageArray insertObject:@(1) atIndex:i];
        }
    }
   
    return _pageArray;
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    for (int i = 0; i < _titlesArray.count; i++) {
        NSMutableArray  *tempArray = [NSMutableArray array];
        [_dataArray addObject:tempArray];
    }
    return  _dataArray;
}

#pragma mark - dataArray

- (void) loadDataModel:(BOOL)refresh index:(NSUInteger)index{
    if (!_pageArray) {
        _pageArray = self.pageArray;
    }
    if (refresh) {
        _pageArray[index] = @(kDefaultStartPage);
    }
    else {
        // 对象可以是乱码 要转换成整形
        _pageArray[index] = @([_pageArray[index] integerValue] + 1);
    }
    // 必须要强转成int类型 NSUInteger会参数错误 
    NSString *urlStr = [NSString stringWithFormat:_urlArray[index],(int)_pageArray[index]];
    // 异步加载 可能加载完视图还没有开始加载数据
    _manager = [AFHTTPSessionManager articleManager];
    [_manager
     GET:urlStr
     parameters:nil
     success:^(NSURLSessionDataTask *task, id responseObejct) {
         if(refresh) {
             // 刷新要移除对象
             [_dataArray[index] removeAllObjects];
         }
         // 判断当前版本不支持5及以下
         for (NSDictionary *objDict in responseObejct[@"result"]) {
             LXKWeiXinFrameModel *model = [LXKWeiXinFrameModel new];
             model.model = [LXKWeiXinModel yy_modelWithDictionary:objDict];
             [_dataArray[index] addObject:model];
         }
         // 必须要在解析数据成功后就刷新视图 否侧集合视图的委托方法都不会回调   因为单元格复用才调用协议的回调方法
         [_pageMulViewsArray[index] reloadData];
         [self endRefreshing:_pageMulViewsArray[index]];
         
         if (refresh) {
             MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                 [self loadDataModel:NO index:index];
             }];
             UITableView *tableView = _pageMulViewsArray[index];
             tableView.mj_footer = footer;
         }
     }
     failure:^(NSURLSessionDataTask * task, NSError *error) {
         NSLog(@"%@",error);
         if ((NSUInteger)_pageArray[index] > 1) {
             _pageArray[index] = @((NSUInteger)_pageArray[index] - 1);
             [self endRefreshing:_pageMulViewsArray[index]];
             [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络设置"];
         }
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger index = tableView.tag;
    return ((NSMutableArray *)self.dataArray[index]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXKRootTableViewCell *cell = [LXKRootTableViewCell cellInTableView:tableView forIndexPath:indexPath];
    NSUInteger index = tableView.tag;
    cell.frameModel = ((NSMutableArray *)_dataArray[index])[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = tableView.tag;
    LXKWeiXinFrameModel *frameModel = ((NSMutableArray *)_dataArray[index])[indexPath.row];
    return frameModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXKWebViewController *webVC = [[LXKWebViewController alloc] init];
    NSUInteger index = tableView.tag;
    LXKWeiXinFrameModel *model = ((NSMutableArray *)_dataArray[index])[indexPath.row];
    webVC.model = model.model;
    [self.navigationController pushViewController:webVC animated:YES];
}

// 动画效果
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    //转动特效
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    //cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 0.7;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//    
//    
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CATransform3DIdentity;
//        cell.alpha = 1;
//        cell.layer.shadowOffset = CGSizeMake(0, 0);
//    }];
//}


@end
