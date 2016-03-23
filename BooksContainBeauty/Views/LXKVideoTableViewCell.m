//
//  LXKVideoTableViewCell.m
//  BooksContainBeauty
//
//  Created by xingkuanlin on 16/3/23.
//  Copyright © 2016年 XingkuanLin. All rights reserved.
//

#import "LXKVideoTableViewCell.h"

@implementation LXKVideoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Y值为负数才可以去滑动的效果
        _pImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -50,[UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.width * 0.62))];
        [self addSubview:_pImgView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImgName:(NSString *)imgName
{
    [_pImgView loadImageWithUrlString:imgName];
}

- (void)scrollImageInTableView:(UITableView *)tableView inView:(UIView *)view
{
    // 1. 找出cell在ViewController的view中的位置。将cell相对于tableview的frame转换成相对于view的frame
    CGRect inSuperRect = [tableView convertRect:self.frame toView:view];
    
    // 2. 计算出cell的起始位置相对于 view的中线的差值。
    CGFloat dis = CGRectGetMidY(view.frame) - CGRectGetMinY(inSuperRect);
    
    // 2.1 计算出imageView的高度和cell的高度差
    CGFloat dif = CGRectGetHeight(self.pImgView.frame) - CGRectGetHeight(self.frame);
    
    // 3. 计算出imageView应该移动的距离。
    CGFloat moveDis = dis / CGRectGetHeight(view.frame) * dif;
    
    // 4. 让image移动
    CGRect imgRect = self.pImgView.frame;
    imgRect.origin.y = -dif * 0.5 + moveDis;
    
    self.pImgView.frame = imgRect;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
