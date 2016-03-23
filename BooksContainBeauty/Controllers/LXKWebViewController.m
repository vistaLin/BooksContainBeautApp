//
//  LXKWebViewController.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/3/1.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKWebViewController.h"
#import "LXKDbHelper.h"
#import <SVProgressHUD.h>
#import "LXKColletedVC.h"

@interface LXKWebViewController ()<UIWebViewDelegate>

@property (nonatomic, assign) BOOL collected;
@property (nonatomic, strong) UIBarButtonItem *item;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LXKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    // 直接拆包找图标或者自己画 不好找
    // 按钮是定制就才不会蓝色的选染色
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 20, 20);
    
    // 肯定要先查询是否收藏再来判断按钮的状态
    if ([[LXKDbHelper helper] collected:_model.url]) {
        _button.selected = YES;
    } else {
        _button.selected = NO;
    }

    
    // 为什么判定第一次无效
    [_button setImage:[[UIImage imageNamed:@"love"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_button setImage:[[UIImage imageNamed:@"loved"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_button addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];
    if (_model.url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //可以添加缓冲的图片 有时间在做
    _webView.delegate = self;
    if (_model.url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
    }
}

- (void)rightButtonClicked:(UIButton *) sender
{
    if (sender.selected == NO) {
        if ([[LXKDbHelper helper] addToCollect:_model]) {
            // 不能在视图控制器里控制别的视图控制器
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            sender.selected = YES;
            _collected = YES;
        } else {
            [SVProgressHUD showErrorWithStatus:@"收藏失败"];
            sender.selected = NO;
            _collected = NO;
        }
    } else {
        if ([[LXKDbHelper helper] removeFromCollect:_model.url]) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            sender.selected = NO;
            _collected = YES;
        } else {
            [SVProgressHUD showErrorWithStatus:@"取消收藏未成功"];
            sender.selected = YES;
            _collected = NO;
        }
    }
}


@end



