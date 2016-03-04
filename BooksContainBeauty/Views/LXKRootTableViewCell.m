//
//  LXKRootTableViewCell.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKRootTableViewCell.h"

@implementation LXKRootTableViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 必须要创建了才有值 为什么这个值不对啊？
        CGFloat w = self.frame.size.width;
        NSLog(@"w  = %lf",w);
        CGFloat h = self.frame.size.height;
        NSLog(@"h = %lf",h);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,w - 10, h - 10)];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, h * 7 / 10, w, h / 10)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//
//   
//}

- (void)setModel:(LXKWeiXinModel *)model
{
    _model = model;
    [_imageView loadImageWithUrlString:_model.picUrl];
    
    _titleLabel.text = _model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
