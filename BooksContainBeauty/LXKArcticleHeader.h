//
//  LXKArcticleHeader.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#ifndef BooksContainBeauty_LXKArcticleHeader_h
#define BooksContainBeauty_LXKArcticleHeader_h

static const NSUInteger kDefaultStartPage = 1;
static const NSUInteger kDefaultPageSize = 20;

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

//如果需要使用参数不能完全填完整
#define API_ARTCLE @"http://api.huceo.com/wxnew/other/?key=0bec4d4cfb4d974dc87301befc49a458&num=20&page=%ld"

#endif
