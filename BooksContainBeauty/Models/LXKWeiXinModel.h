//
//  LXKWeiXinModel.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXKWeiXinModel : NSObject

/**文章的描述*/
@property (nonatomic, copy) NSString *desc;
/**更新的时间*/

@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, copy) NSString *hottime;

/**文章的标题*/
@property (nonatomic, copy) NSString *title;
/**查看详情的URL*/
@property (nonatomic, copy) NSString *url;
/**图片的URL*/
@property (nonatomic, copy) NSString *picUrl;

@end
