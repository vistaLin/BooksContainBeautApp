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
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
// 标题大小
#define FONT_TITLE [UIFont systemFontOfSize:15]
// 时间与来源的字体大小
#define FONT_TIME [UIFont systemFontOfSize:10]

//如果需要使用参数不能完全填完整0bec4d4cfb4d974dc87301befc49a458
//微文的PAI
#define API_ARTCLE @"http://api.huceo.com/wxnew/other/?key=0bec4d4cfb4d974dc87301befc49a458&num=10&page=%ld"

//国内的API
#define API_HOME @"http://api.avatardata.cn/WorldNews/Query?key=2a7796d0ab794995b8157c2a8059de85&page=%ld&rows=10"

//国际的API
#define APT_WORLD @" http://api.avatardata.cn/WorldNews/Query?key=2a7796d0ab794995b8157c2a8059de85&page=%ld&rows=10"



#endif
