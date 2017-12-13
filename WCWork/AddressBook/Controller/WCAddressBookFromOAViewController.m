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
#import <MessageUI/MessageUI.h>

#define ADDRESS_URL @"http://mobile.zjmi.com:8080/app/oauth?app=book&loginid="

@interface WCAddressBookFromOAViewController ()<WKNavigationDelegate,WKUIDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, weak)  WKWebView *webView;
@property (nonatomic, strong)  UIWebView *telWebView;
@end

@implementation WCAddressBookFromOAViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WCStatusBarH)];
    statusBarView.backgroundColor = RGB(0, 122, 251);
    [self.view addSubview:statusBarView];
   
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
    
    //登录帐号
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    NSString *userName = loginVc.loginAccount.userName;
    NSString *url = [NSString stringWithFormat:@"%@%@",ADDRESS_URL,userName];
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


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        [self.telWebView loadRequest:[NSURLRequest requestWithURL:URL]];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if ([scheme isEqualToString:@"sms"]) {
        //显示发短信的控制器
        MFMessageComposeViewController *messageVc = [[MFMessageComposeViewController alloc] init];
        //设置短信内容
        messageVc.body = @"";
        //设置收件人列表
        NSString *tel = [[URL absoluteString] substringFromIndex:[[URL absoluteString] rangeOfString:@":"].location + 1];
        messageVc.recipients = @[tel];
        //设置代理
        messageVc.messageComposeDelegate = self;
        //显示控制器
        [self presentViewController:messageVc animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (UIWebView *)telWebView {
    if (_telWebView == nil) {
        _telWebView = [[UIWebView alloc] init];
    }
    return _telWebView;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    //关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:^{
        if (result == MessageComposeResultCancelled) {
            [MBProgressHUD showError:@"取消发送"];
        }else if (result == MessageComposeResultSent) {
            [MBProgressHUD showSuccess:@"已发送"];
        }else{
            [MBProgressHUD showError:@"发送失败"];
        }
    }];
}

#pragma mark - dealloc
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
