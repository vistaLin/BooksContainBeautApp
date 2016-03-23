//
//  LXKMainTabBarController.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/21.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKMainTabBarController.h"
#import "LXKRootViewController.h"
#import "LXKColletedVC.h"
#import "LXKVideoViewController.h"


@interface LXKMainTabBarController ()

@property (nonatomic, strong) LXKColletedVC *colletVC;

@end

@implementation LXKMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 定制分栏的视图控制器
    NSArray *tabBarItemNames = @[@"修文", @"行走", @"如玉"];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < tabBarItemNames.count; i++) {
        if (i == 0) {
            LXKRootViewController *rootVC = [LXKRootViewController new];
            rootVC.title = tabBarItemNames[i];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
            [viewControllers addObject:nav];
        } else if (i == 1) {
            LXKVideoViewController *videoVC = [LXKVideoViewController new];
            videoVC.title = tabBarItemNames[i];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoVC];
            [viewControllers addObject:nav];
        } else if(i == 2) {
            _colletVC = [LXKColletedVC new];
            _colletVC.title = tabBarItemNames[i];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_colletVC];
            [viewControllers addObject:nav];
        }
    }
    self.viewControllers = viewControllers;
    
    // 定制分栏项
    NSUInteger select = 200;
    NSArray *imageNames = @[@"new", @"girl", @"loved"];
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        UIImage *image = [[UIImage imageNamed:imageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        select += i;
        item = [item initWithTitle:tabBarItemNames[i] image:image tag:select];
    }
}


@end
