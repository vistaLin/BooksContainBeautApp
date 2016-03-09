//
//  LXKWeiXinFrameModel.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/3/5.
//  assignright (c) 2016年 XingkuanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXKWeiXinFrameModel : NSObject

/**
 *  需要传入数据模型来计算所有控件的位置
 */
@property (nonatomic, strong) LXKWeiXinModel *model;

// CGRect是结构体，不是指针
/**更新的时间和来源的边框*/
@property (nonatomic, assign) CGRect hottimeAndDescLabelFrame;

/**图片的边框*/
@property (nonatomic, assign) CGRect imageViewFrame;

/**文章的标题的边框*/
@property (nonatomic, assign) CGRect titleLabelFrame;

/**
 *   单元格的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
