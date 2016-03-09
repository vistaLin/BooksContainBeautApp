//
//  LXKLog.h
//  BooksContainBeauty
//
//  Created by 千锋 on 16/2/24.
//  Copyright (c) 2016年 XingkuanLin. All rights reserved.
//

#ifndef BooksContainBeauty_LXKLog_h
#define BooksContainBeauty_LXKLog_h

/*
 如玉云开发日志
 数据：一：UITabBarController
      1.第一个页面：微信精选   2.第二个页面：实时新闻  3.第三个页面：搜索栏：有成语，词语，历史的今天，姓氏的起源，名人名言等
      二：侧边栏效果：
      1.我的收藏  2.设置模式   
 效果：1.利用MVC架构
      2.有tabBar的界面
      3.有侧边栏效果
      4.有数据库进行收藏
      5.对一些图示进行缩放
 
 2016.2.24
 ------------------
 问题1:如何把已存在的file加到已经存在在项目里的文件中？
     1.打开Show in Finder把文件拖入项目中，然后在左菜单栏中删除，再重新从Show in Finder中拖入文件。
 问题2.如果不使用stroyboard并且删除创建项目已经存在的viewController那么需要在项目中的Info.plist把main置为空
 
 2016.2.26
 -----------------

 1.如果Podfile出错可以在终端输入ls -a查看隐藏的Podfile文件删除在重新创建。
 2.微信热门精选的apikey：3c29978baf3f9eb3b487b6307853e75b
 3.宏保护：
 #ifndef W_H_
 #define W_H_
 #define  WIDTH self.view.bounds.size.width
 #define  HEIGHT self.view.bounds.size.height
 #endif
 
 2016.2.27
 -------------------
 1.PCH里面要是那个框架里面的类型必须导入那个框架。不然会报错。
 
 2016.3.9
 --------------
 1.数据为空，登陆网站查看json数据是否更改过。
 
 */


#endif
