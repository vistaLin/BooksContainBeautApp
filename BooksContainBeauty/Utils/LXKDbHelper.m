//
//  LXKDbHelper.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/13.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKDbHelper.h"
#import "LXKWeiXinModel.h"
#import <FMDB.h>

@implementation LXKDbHelper {
    FMDatabase *_db;
}

- (instancetype)init
{
   @throw [NSException exceptionWithName:@"不能通过此方法初始化" reason:@"这是一个单例，请使用helper" userInfo:nil];
}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        NSString *dbFilePath = [NSString stringWithFormat:@"%@/Documents/BooksContainBeauty.db",NSHomeDirectory()];
        _db = [FMDatabase databaseWithPath:dbFilePath];
        if (_db && [_db open]) {
            NSString *sql = @"create table if not exists TbCollect (url varchar(100) primary key,title varchar(100) not null,ctime varchar(20))";
            if ([_db executeUpdate:sql]) {
                [_db close];
            } else {
                NSLog(@"创建收藏表失败");
            }
        } else {
            NSLog(@"无法创建或者打开数据库");
        }
    }
    return self;
}

+ (instancetype)helper
{
    static LXKDbHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] initPrivate];
        }
    });
    return instance;
}

- (NSArray *)getAllCollects
{
    NSMutableArray *collects = [NSMutableArray array];
    if (_db && [_db open]) {
        NSString *sql = @"select * from TbCollect";
        FMResultSet *rs = [_db executeQuery:sql];
        while ([rs next]) {
            LXKWeiXinModel *model = [LXKWeiXinModel new];
            model.url = [rs stringForColumn:@"url"];
            model.ctime = [rs stringForColumn:@"ctime"];
            model.title = [rs stringForColumn:@"title"];
            // 改变数据顺序可以直接插入 这样添加的时候就在第一行
            [collects insertObject:model atIndex:0];
        }
        [_db close];
    }
    return [collects copy];
}

- (BOOL)collected:(NSString *)url
{
    BOOL isCollected = NO;
    if (_db && [_db open]) {
        NSString *sql = @"select * from TbCollect where url=?";
        FMResultSet *rs = [_db executeQuery:sql,url];\
        isCollected = [rs next];
        [_db close];
    }
    return isCollected;
}

- (BOOL) addToCollect:(LXKWeiXinModel *)model
{
    BOOL isSuccess = NO;
    if (_db && [_db open]) {
        NSString *sql = @"insert into TbCollect values (?,?,?)";
        isSuccess = [_db executeUpdate:sql,model.url,model
                     .title,model.ctime];
        [_db close];
    }
    return  isSuccess;
}

- (BOOL)removeFromCollect:(NSString *)url
{
    BOOL isSuccess = NO;
    if (_db && [_db open]) {
        NSString *sql = @"delete from TbCollect where url=?";
        isSuccess = [_db executeUpdate:sql,url];
        [_db close];
    }
    return isSuccess;
}

@end
