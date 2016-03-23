//
//  UIImageView+Util.m
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/27.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#import "UIImageView+Util.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Util)

- (void)loadImageWithUrlString:(NSString *)urlStr
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
}

@end
