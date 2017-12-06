//
//  WCDynamicDetailController.m
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDynamicDetailController.h"
#import "WCDynamicDetailParam.h"
#import "WCNoWifiView.h"
#import "WCHomeTool.h"

#import <WebKit/WebKit.h>

@interface WCDynamicDetailController () <WKNavigationDelegate,WKUIDelegate,WCNoWifiViewDelegate>
@property (nonatomic, weak) UIScrollView  *dynamicDetailView;
@property (nonatomic, weak) UILabel  *titleLabel;
@property (nonatomic, weak) UILabel  *timeLabel;
@property (nonatomic, weak) WKWebView  *webView;
@property (nonatomic, strong)  WCNoWifiView *noWifiView;
@end

@implementation WCDynamicDetailController

- (instancetype)initWithWcDynamic:(WCDynamic *)wcDynamic {
    if (self = [super init]) {
        _wcDynamic = wcDynamic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.加载界面
    [self setupUI];
    
    // 2.加载数据
    [self setupData];
}

- (void)setupUI {
    UIScrollView *dynamicDetailView = [[UIScrollView alloc] init];
    dynamicDetailView.frame = self.view.bounds;
    _dynamicDetailView = dynamicDetailView;
    [self.view addSubview:dynamicDetailView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10.0f, 10.0f, ScreenW - 2 * 10, 80);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font =  [UIFont boldSystemFontOfSize:20.0f];
    _titleLabel = titleLabel;
    [dynamicDetailView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(ScreenW / 2 - 90.0f, 90.0f, 180.0f, 20.0f);
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:12.0f];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel = timeLabel;
    [dynamicDetailView addSubview:timeLabel];
    
    // 客户端添加meta标签eg
    /*NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];*/
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    /*
    不推荐在客户端设置字体大小
    //创建设置对象
    WKPreferences *preference = [[WKPreferences alloc] init];
    //设置字体大小
    preference.minimumFontSize = 40;
    //设置偏好设置对象
    config.preferences = preference;
    
    //config.userContentController = wkUController;
    */
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, 110.0f, ScreenW, ScreenH - 110.0f - WCTopNavH) configuration:config];
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    _webView = webView;
    [dynamicDetailView addSubview:webView];
}

- (void)setupData {
    [self.noWifiView hide];
    WCDynamicDetailParam *param = [WCDynamicDetailParam param:dynamicDetail];
    param.contentId = _wcDynamic.ContentId;
    [WCHomeTool dynamicDetailWithParam:param success:^(WCDynamicDetailResult *dynamicDetailResult) {
        self.titleLabel.text = dynamicDetailResult.Title;
        self.timeLabel.text = dynamicDetailResult.AddDate;
        if (dynamicDetailResult.Message) {
            [self.webView loadHTMLString:dynamicDetailResult.Message baseURL:nil];
        }
    } failure:^(NSError *error) {
        [self.noWifiView show];
    }];
}

#pragma mark - noWifiView / noWifiViewDelegate
- (WCNoWifiView *)noWifiView {
    if (!_noWifiView) {
        _noWifiView = [[WCNoWifiView alloc] init];
        _noWifiView.center = CGPointMake(ScreenW / 2, ScreenH / 2 - 64);
        _noWifiView.delegate = self;
        [self.dynamicDetailView addSubview:_noWifiView];
    }
    return _noWifiView;
}

- (void)noWifiViewDidRefreshBtn:(WCNoWifiView *)noWifiView {
    [self setupData];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //修改字体大小 300%
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    
    //修改字体颜色  #9098b8
//    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:nil];
}

#pragma mark -屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
