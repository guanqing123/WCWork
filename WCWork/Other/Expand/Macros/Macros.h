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
/** 状态栏高度 */
#define WCStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height
/** 导航栏高度 */
#define WCNaviH 44.0
/** 顶部Nav高度+指示器 */
#define WCTopNavH (WCStatusBarH + WCNaviH)
/** 底部tab高度 */
#define WCBottomTabH (WCStatusBarH > 20 ? 83 : 49)

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//主题色
#define WCThemeColor RGB(53, 123, 202)

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


//物产URL
#define WCURL @"http://mobile.zjmi.com:8080/app/api"
//EMAIL
#define EMAILURL @"http://mobile.zjmi.com:8080/app/email?email="
//OA
#define OAURL @"http://mobile.zjmi.com:8080/app/oauth?app=ebridge&loginid="
//智慧党建
#define PARTYURL @"http://mobile.zjmi.com:8080/app/oauth?app=dangjian&loginid="
//物产中大报
#define NEWSPAPER @"http://weixin.zjmi.com/zjmimvc/Mobile/newspaper/index"

//首页滚动条
#define slider @"HYXK00019"
//首页Segement
#define homeSegement @"ZJMI00002"
//公司行情
#define dynamic @"HYXK00003"
//详细新闻
#define dynamicDetail @"ZJMI00001"
//通讯录
#define addressBookList @"SUNON00002"
//登录
#define login @"SUNON00001"
//常见问题
#define commonProblemUrl @"HYXK00006"
//考勤
#define KQ1 @"SUNON00006"
#define KQ2 @"SUNON00007"
//新品上市
#define newArrival @"HYXK00027"
//经典作品
#define classicWorkUrl @"HYXK00020"

//自动登录
#define WCAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#endif /* Macros_h */
