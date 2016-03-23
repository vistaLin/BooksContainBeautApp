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

#ifndef W_H_
#define W_H_
#define  WIDTH self.view.bounds.size.width
#define  HEIGHT self.view.bounds.size.height
#endif

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
// 标题大小
#define FONT_TITLE [UIFont systemFontOfSize:15]
// 时间与来源的字体大小
#define FONT_TIME [UIFont systemFontOfSize:10]

//如果需要使用参数不能完全填完整0bec4d4cfb4d974dc87301befc49a458
//微文的PAI
#define API_ARTCLE @"http://api.huceo.com/wxnew/other/?key=0bec4d4cfb4d974dc87301befc49a458&num=10&page=%ld"

//国内的API
#define API_HOME @"http://api.avatardata.cn/GuoNeiNews/Query?key=60b663e9f3254193baa97f52cec584aa&page=%d&rows=10"

//国际的API 有空格致使断言失败 然后无效的参数
#define API_WORLD @"http://api.avatardata.cn/WorldNews/Query?key=2a7796d0ab794995b8157c2a8059de85&page=%ld&rows=10"

// 科技的API
#define API_SCIENCE @"http://api.avatardata.cn/TechNews/Query?key=b3d9eb769d4c4161b5906692e020b5db&page=%ld&rows=10"

// 体育的API
#define API_SPORTS @"http://api.avatardata.cn/SportsNews/Query?key=4aa65e8fab4b44b6a191fdc9715994c7&page=%ld&rows=10"

// 奇闻的API
#define API_ANECDOTE @"http://api.avatardata.cn/QiWenNews/Query?key=8233e94d7086435c9fd7fb2f56332bb0&page=%ld&rows=10"

// 旅行
#define APT_TRAVEL @"http://api.avatardata.cn/TravelNews/Query?key=dd89f80f9552466ea94e50cd16c50631&page=1&rows=10"

//读书页面的的API
#define API_BOOKS @"http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?platform=android&installversion=5.7.0.1&channelno=TBSCA2320480100&mid=ad9c68cbb2d1b46f833c68f3600af26f&uid=12397266&sid=3a75a429-adc0-42d9-9f2b-d13929f86aa8&type=1&id=47&category=1&ot=0&nt=0&t=1458576196158"

// 旅行视频第一个没有参数
#define API_VIDEO_FIRST @"http://baobab.wandoujia.com/api/v3/videos?categoryName=%E6%97%85%E8%A1%8C&strategy=date&udid=7b9e6fb4440f4db1a2e71c20e67961f1490e3b76&vc=89&vn=1.13.1&deviceModel=MX4%20Pro&first_channel=eyepetizer_PP_market&last_channel=eyepetizer_PP_market"
// 旅行视频http://baobab.wandoujia.com/api/v3/videos?start=%ld&num=10&categoryName=%E6%97%85%E8%A1%8C&strategy=date&udid=7b9e6fb4440f4db1a2e71c20e67961f1490e3b76&vc=89&vn=1.13.1&deviceModel=MX4%20Pro&first_channel=eyepetizer_PP_market&last_channel=eyepetizer_PP_market
#define API_VIDEO @"http://baobab.wandoujia.com/api/v3/videos?start=%ld&num=10&categoryName=%E6%97%85%E8%A1%8C&strategy=date&udid=7b9e6fb4440f4db1a2e71c20e67961f1490e3b76&vc=89&vn=1.13.1&deviceModel=iPhone6s&first_channel=eyepetizer_PP_market&last_channel=eyepetizer_PP_market"




#endif
