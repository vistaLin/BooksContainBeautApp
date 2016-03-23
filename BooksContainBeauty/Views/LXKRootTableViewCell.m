//
//  LXKRootTableViewCell.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKRootTableViewCell.h"
#import "LXKWeiXinFrameModel.h"

@implementation LXKRootTableViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
}

+ (LXKRootTableViewCell *)cellInTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    // 不能添加常量const
    static NSString *CellID = @"CellID";
    LXKRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[LXKRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        
        _timeLabel = [UILabel new];
        // 请不要那么愚蠢 记得在设置大小并且在frame哪里计算也需要设置
        _timeLabel.font = FONT_TIME;
        [self.contentView addSubview:_timeLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = FONT_TITLE;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
//        // 必须要创建了才有值 为什么这个值不对啊？
//        CGFloat w = self.frame.size.width;
//        NSLog(@"w  = %lf",w);
//        CGFloat h = self.frame.size.height;
//        NSLog(@"h = %lf",h);
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,w - 10, h - 10)];
//        [self.contentView addSubview:_imageView];
//        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, h * 7 / 10, w, h / 10)];
//        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setFrameModel:(LXKWeiXinFrameModel *)frameModel
{
    _frameModel = frameModel;
    _imageView.frame = frameModel.imageViewFrame;
    [_imageView loadImageWithUrlString:frameModel.model.picUrl];

    
    _titleLabel.frame = frameModel.titleLabelFrame;
    _titleLabel.text = frameModel.model.title;
    
    _timeLabel.frame = frameModel.hottimeAndDescLabelFrame;
    if (frameModel.model.ctime) {
        _timeLabel.text = [NSString stringWithFormat:@"%@   %@",frameModel.model.desc,frameModel.model.ctime];
    }else if (!frameModel.model.ctime ){
        _timeLabel.text = frameModel.model.desc;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end
