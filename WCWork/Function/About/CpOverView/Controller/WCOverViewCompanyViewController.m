//
//  WCOverViewCompanyViewController.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCOverViewCompanyViewController.h"
#import <WebKit/WebKit.h>
#import "WCOverViewCompanyTool.h"

@interface WCOverViewCompanyViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, weak)  WKWebView *webView;
@end

@implementation WCOverViewCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self setUpData];
}

- (void)setUpData {
    WCOverViewCompanyParam *param = [WCOverViewCompanyParam param:overViewCompany];
    [WCOverViewCompanyTool overViewCompanyWithParam:param success:^(NSString *content) {
        [self.webView loadHTMLString:content baseURL:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常"];
    }];
}

#pragma mark - WK
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

#pragma mark - memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
