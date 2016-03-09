

//
//  LXKWeiXinFrameModel.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/3/5.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "LXKWeiXinFrameModel.h"

static const CGFloat margin = 6;

@implementation LXKWeiXinFrameModel

- (void)setModel:(LXKWeiXinModel *)model
{
    _model = model;
    
    CGFloat imageViewW = SCREENWIDTH - 2 * margin;
    CGFloat imageViewH = SCREENWIDTH * 3 / 5;
    self.imageViewFrame = CGRectMake(margin, margin,imageViewW, imageViewH);
    
    CGFloat titleY = CGRectGetMaxY(self.imageViewFrame) + margin;
    NSString *titleStr = _model.title;
    CGSize titleSize = [titleStr boundingRectWithSize:CGSizeMake(imageViewW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_TITLE} context:nil].size;
    self.titleLabelFrame = (CGRect){CGPointMake(margin,titleY),titleSize};
    
    CGFloat timeY = CGRectGetMaxY(self.titleLabelFrame);
    NSString *timeStr = _model.ctime;
    CGSize timeSize = [timeStr sizeWithAttributes:@{NSFontAttributeName : FONT_TIME}];
   // NSLog(@"tiemH = %lf",timeSize.height);
    //NSLog(@"tiemW = %lf",timeSize.width);
    CGFloat timeH = timeSize.height + margin;
    self.hottimeAndDescLabelFrame = CGRectMake(margin, timeY +margin, imageViewW, timeH);
   
    self.cellHeight = imageViewH + titleSize.height + timeH + 4 * margin;
}

@end
