//
//  LXKVideoModel.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/22.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKVideoModel.h"

@implementation LXKData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"data" : [LXKVideoModel class]};
}

@end

@implementation LXKVideoModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"description" : @"desc"};
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"Consumption" : [LXKConsumption class],
              @"Provider" : [LXKProvider class],
              @"Cover" : [LXKCover class],
              @"Weburl" : [LXKWeburl class],
              @"Playinfo" : [LXKPlayinfo class]};
}

@end


@implementation LXKConsumption

@end


@implementation LXKProvider

@end


@implementation LXKCover

@end


@implementation LXKWeburl

@end


@implementation LXKPlayinfo

@end


