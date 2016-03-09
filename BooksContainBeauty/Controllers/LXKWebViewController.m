//
//  LXKWebViewController.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/3/1.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKWebViewController.h"

@interface LXKWebViewController ()

@end

@implementation LXKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor greenColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
//    _webView.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_webView];
    if (_url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

@end
