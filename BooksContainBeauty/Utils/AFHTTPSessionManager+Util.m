//
//  AFHTTPSessionManager+Util.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "AFHTTPSessionManager+Util.h"

static const NSUInteger kDefaultTimeoutInterval = 10;

@implementation AFHTTPSessionManager (Util)

+ (instancetype) articleManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    return manager;
    
}

@end
