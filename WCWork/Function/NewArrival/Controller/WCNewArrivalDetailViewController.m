//
//  WCNewArrivalDetailViewController.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCNewArrivalDetailViewController.h"

@interface WCNewArrivalDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel  *timeLabel;
@property (nonatomic, weak)  WKWebView *wkWebView;
@end

@implementation WCNewArrivalDetailViewController

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
    titleLable.frame = CGRectMake(10.0f, 10.0f + 64.0f, self.view.frame.size.width - 20, 50);
    titleLable.numberOfLines = 0;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = _newsTitle;
    titleLable.font = [UIFont boldSystemFontOfSize:20.0f];
    _timeLabel = titleLable;
    [self.view addSubview:titleLable];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(self.view.frame.size.width / 2 - 60, 60.0f + 64.0f, 120, 20);
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.text = _newsTime;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel = titleLable;
    [self.view addSubview:timeLabel];
    
    // 客户端添加meta标签eg
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = wkUController;
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 80.0f + 64.0f, self.view.frame.size.width, self.view.frame.size.height - 144.0f) configuration:config];
    wkWebView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:@"http://218.75.78.166:9101"];
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
