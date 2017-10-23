//
//  WCClassicWorkDetailViewController.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCClassicWorkDetailViewController.h"
#import <WebKit/WebKit.h>

@interface WCClassicWorkDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, copy) NSString *path;
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation WCClassicWorkDetailViewController

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _path = path;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    
    NSURL *url = [NSURL URLWithString:_path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WKWebView *webView = [[WKWebView alloc] init];
    webView.navigationDelegate = self;
    webView.frame = self.view.bounds;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [webView sizeToFit];
    [webView loadRequest:request];
    _webView = webView;
    [self.view addSubview:webView];
}

- (void)back {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - navigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

@end
