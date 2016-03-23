//
//  LXKWebViewController.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/3/1.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXKWeiXinModel;
@class LXKReadingBooksModel;

@interface LXKWebViewController : UIViewController

@property (nonatomic, strong) LXKWeiXinModel *model;

@property (nonatomic, strong) LXKReadingBooksModel *bookModel;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIButton *button;

@end
