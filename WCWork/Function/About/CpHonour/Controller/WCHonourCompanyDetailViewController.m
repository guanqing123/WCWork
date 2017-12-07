//
//  WCHonourCompanyDetailViewController.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//


#import "WCHonourCompanyDetailViewController.h"

@interface WCHonourCompanyDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel  *timeLabel;
@property (nonatomic, weak)  WKWebView *wkWebView;
@end

@implementation WCHonourCompanyDetailViewController

- (instancetype)initWithTitle:(NSString *)newsTitle time:(NSString *)newsTime content:(NSString *)newsContent {
    if (self = [super init]) {
        _newsTitle = newsTitle;
        _newsTime = newsTime;
        _content = newsContent;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    
    [self setupUI];
}

- (void)back {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.frame = CGRectMake(10.0f, 10.0f + WCTopNavH, self.view.frame.size.width - 20, 50);
    titleLable.numberOfLines = 0;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = _newsTitle;
    titleLable.font = [UIFont boldSystemFontOfSize:20.0f];
    _titleLable = titleLable;
    [self.view addSubview:titleLable];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    CGFloat timeLabelY = CGRectGetMaxY(_titleLable.frame);
    timeLabel.frame = CGRectMake(self.view.frame.size.width / 2 - 60, timeLabelY, 120, 20);
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.text = _newsTime;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    
    // 客户端添加meta标签eg
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = wkUController;
    
    CGFloat wkWebViewY = CGRectGetMaxY(_timeLabel.frame);
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, wkWebViewY, ScreenW, ScreenH - wkWebViewY) configuration:config];
    wkWebView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:WCURL];
    [wkWebView loadHTMLString:_content baseURL:url];
    wkWebView.backgroundColor = [UIColor whiteColor];
    _wkWebView = wkWebView;
    [self.view addSubview:wkWebView];
}

#pragma mark - wkWebView delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
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
