//
//  EmailViewController.m
//  HYWork
//
//  Created by information on 2017/6/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCEmailViewController.h"

@interface WCEmailViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong)  WKWebView *webView;
@end

@implementation WCEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    //_web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //[self.view addSubview:_web];
    
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    NSString *email = loginVc.loginAccount.email;
    NSString *url = [NSString stringWithFormat:@"%@%@",EMAILURL,email];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)close {
    if (self.webView.loading) {[self.webView stopLoading];}
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    if (self.webView.loading) {[self.webView stopLoading];}
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

- (void)dealloc {
    self.webView.navigationDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
