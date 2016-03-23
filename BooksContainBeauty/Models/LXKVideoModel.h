//
//  LXKVideoModel.h
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/22.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXKConsumption,LXKProvider,LXKCover,LXKWeburl,LXKPlayinfo,LXKVideoModel;

@interface LXKData : NSObject

@property (nonatomic, strong) LXKVideoModel *videoModel;

@end

@interface LXKVideoModel : NSObject


@property (nonatomic, copy) NSString *shareAdTrack;

@property (nonatomic, strong) LXKWeburl *webUrl;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *webAdTrack;

@property (nonatomic, strong) NSArray<LXKPlayinfo *> *playInfo;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *favoriteAdTrack;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, strong) LXKCover *cover;

@property (nonatomic, strong) LXKConsumption *consumption;

@property (nonatomic, copy) NSString *waterMarks;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long date;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSString *promotion;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, strong) LXKProvider *provider;

@property (nonatomic, copy) NSString *campaign;

@property (nonatomic, copy) NSString *author;

/**
 *  详情描述
 */
@property (nonatomic, copy) NSString *desc;



@end
@interface LXKConsumption : NSObject

@property (nonatomic, assign) NSInteger collectionCount;

@property (nonatomic, assign) NSInteger shareCount;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, assign) NSInteger playCount;

@end

@interface LXKProvider : NSObject

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@end

@interface LXKCover : NSObject

@property (nonatomic, copy) NSString *blurred;

@property (nonatomic, copy) NSString *sharing;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *feed;

@end

@interface LXKWeburl : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, copy) NSString *forWeibo;

@end

@interface LXKPlayinfo : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@end

