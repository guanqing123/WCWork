//
//  WCAddressBookFromOAViewController.m
//  WCWork
//
//  Created by information on 2017/12/6.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookFromOAViewController.h"
#import <WebKit/WebKit.h>
#import "NSString+GQExtension.h"

#define ADDRESS_URL @"http://mobile.zjmi.com:8080/app/oauth?app=book&loginid="

@interface WCAddressBookFromOAViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, weak)  WKWebView *webView;
@end

@implementation WCAddressBookFromOAViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WCStatusBarH)];
    statusBarView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:statusBarView];
   
    //登录帐号
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    NSString *userName = loginVc.loginAccount.userName;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ADDRESS_URL,userName];
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, WCStatusBarH, ScreenW, ScreenH - WCBottomTabH - WCStatusBarH);
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
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
