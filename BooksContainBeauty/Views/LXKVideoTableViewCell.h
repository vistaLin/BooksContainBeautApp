//
//  LXKVideoTableViewCell.h
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/23.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXKVideoTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) UIImageView *pImgView;

/** 让cell的image在 tableview 中滑动*/
- (void)scrollImageInTableView:(UITableView *)tableView
                        inView:(UIView *)view;

@end
