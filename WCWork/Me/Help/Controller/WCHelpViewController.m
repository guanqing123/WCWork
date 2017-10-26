//
//  WCHelpViewController.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHelpViewController.h"

#import "WCHtmlViewController.h"
#import "WCNavigationController.h"

#import "SettingArrowItem.h"
#import "SettingGroup.h"
#import "WCHtml.h"

@interface WCHelpViewController ()
@property (nonatomic, strong)  NSArray *htmls;
@end

@implementation WCHelpViewController

- (NSArray *)htmls {
    if (_htmls == nil) {
        
        // JSON文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"json"];
        
        // 加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 将JSON数据转为NSArray或者NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //将字典转成模型
        NSMutableArray *htmlArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WCHtml *html = [WCHtml htmlWithDict:dict];
            [htmlArray addObject:html];
        }
        _htmls = htmlArray;
    }
    return _htmls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.创建所有的item
    NSMutableArray *items = [NSMutableArray array];
    for (WCHtml *html in self.htmls) {
        SettingItem *item = [SettingArrowItem itemWithTitle:html.title destVcClass:nil];
        [items addObject:item];
    }
    
    // 2.创建组
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = items;
    [self.data addObject:group];
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WCHtmlViewController *htmlVc = [[WCHtmlViewController alloc] init];
    htmlVc.html = self.htmls[indexPath.row];
    WCNavigationController *nav = [[WCNavigationController alloc] initWithRootViewController:htmlVc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
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
