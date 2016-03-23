//
//  LXKDbHelper.h
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/13.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXKWeiXinModel;

/**
 *  数据库的CRUD
 */
@interface LXKDbHelper : NSObject

/**
 *  单例 作为全局的可以访问
 *
 *  @return 数据库的CRUD
 */
+ (instancetype)helper;

/**
 *  所有的收藏
 *
 *  @return 所有的收藏
 */
- (NSArray *)getAllCollects;

/**
 *  根据url收藏是否成功
 *
 *  @param 模型的数据查看详情的url
 *
 *  @return 收藏是否成功
 */
- (BOOL)collected:(NSString *)url;

/**
 *  添加模型数据是否成功
 *
 *  @param model 新闻的模型
 *
 *  @return 添加模型是否成功
 */
- (BOOL)addToCollect:(LXKWeiXinModel *)model;

/**
 *  根据url移除收藏是否成功
 *
 *  @param url 新闻模型的url
 *
 *  @return 移除收藏的url成功或失败
 */
- (BOOL)removeFromCollect:(NSString *)url;

@end
