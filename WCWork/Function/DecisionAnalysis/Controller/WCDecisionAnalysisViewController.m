//
//  WCDecisionAnalysisViewController.m
//  WCWork
//
//  Created by information on 2017/12/6.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDecisionAnalysisViewController.h"
#import <WebKit/WebKit.h>
#import "NSString+GQExtension.h"

#define JCFX_URL @"http://biportal.zjmi.com:8080/xplatform/login.action?appSSO=true"

@interface WCDecisionAnalysisViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, weak)  WKWebView *webView;
@end

@implementation WCDecisionAnalysisViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableString *mut = [NSMutableString string];
    
    //登录帐号
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    NSString *userName = loginVc.loginAccount.userName;
    NSString *password = loginVc.loginAccount.password;
    
    [mut appendString:userName];
    [mut appendString:@"/"];
    [mut appendString:[[NSString md5DigestWithString:password] uppercaseString]];
    [mut appendString:@"/zjmibo/"];
    
    //时间戳，根据函数生成，服务端验证时判断与服务器的时间戳，绝对值相差不超过300秒
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSInteger t = (NSInteger)time;
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",t];
    [mut appendString:timeStamp];
    
    // appkey=md5(admin/md5(Zmi@123456)/zjmibo/时间戳)
    // （账号/大写的密文（MD5加密密码）/约定KEY值/时间戳
    NSString *appKey = [[NSString md5DigestWithString:mut] uppercaseString];
    
    NSString *url = [NSString stringWithFormat:@"%@&passport=%@&appKey=%@&time=%@",JCFX_URL,userName,appKey,timeStamp];
    
    // 1.背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 2.返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    // 3.关闭按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, WCTopNavH, ScreenW, ScreenH - WCTopNavH);
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    _webView = webView;
    [self.view addSubview:_webView];
    
    if (@available(iOS 11.0,*)) {
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)close {
    if (self.webView.loading) {[self.webView stopLoading];}
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        if (self.webView.loading) {[self.webView stopLoading];}
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //修改字体大小 300%
    //    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVc.view.backgroundColor = [UIColor whiteColor];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alertVc animated:YES completion:^{}];
}

- (void)dealloc {
    self.webView.navigationDelegate = nil;
    self.webView.UIDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
