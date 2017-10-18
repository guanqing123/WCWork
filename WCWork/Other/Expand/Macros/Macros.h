//
//  Macros.h
//  WCWork
//
//  Created by information on 2017/9/28. desc 宏
//  Copyright © 2017年 hongyan. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define NAV

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//主题色
#define WCThemeColor RGB(0, 157, 133)

//cell line color
#define cellLineColor RGB(238,238,238)

//navBar字体
#define navBarTitleColor [UIColor whiteColor]
#define navBarTitleFont  [UIFont systemFontOfSize:15]
//tabBar字体
#define tabBarTitleColorNomal [UIColor lightGrayColor]
#define tabBarTitleColorSelected WCThemeColor

//自定义Log
#ifdef DEBUG  // 调试阶段
#define WCLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define WCLog(...)
#endif


//鸿雁销客
#define XKURL @"http://218.75.78.166:9101/app/api"

#define WCURL @"http://sge.cn:9109/app/api"

//首页滚动条
#define slider @"HYXK00019"
//公司行情
#define dynamic @"HYXK00003"
//详细新闻
#define dynamicDetail @"ZJMI00001"
//通讯录
#define addressBookList @"SUNON00002"

#endif /* Macros_h */
