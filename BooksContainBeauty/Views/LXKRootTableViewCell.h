//
//  LXKRootTableViewCell.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXKWeiXinFrameModel;

@interface LXKRootTableViewCell : UITableViewCell

@property (nonatomic, strong) LXKWeiXinFrameModel *frameModel;

+ (LXKRootTableViewCell *)cellInTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

@end
