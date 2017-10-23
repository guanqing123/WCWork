//
//  CjwtCell.m
//  HYWork
//
//  Created by information on 16/7/7.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCCommonProblemCell.h"

@interface WCCommonProblemCell()
@property (weak, nonatomic) IBOutlet UIWebView *reasonWeb;
@property (weak, nonatomic) IBOutlet UIWebView *solutionWeb;

@end

@implementation WCCommonProblemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"WCCommonProblemCell";
    WCCommonProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCCommonProblemCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setCommonProblem:(WCCommonProblem *)commonProblem {
    _commonProblem = commonProblem;
    
    NSURL *url = [NSURL URLWithString:@"http://218.75.78.166:9101"];

    [self.reasonWeb loadHTMLString:commonProblem.reason baseURL:url];
    [self.solutionWeb loadHTMLString:commonProblem.solution baseURL:url];
    
}

@end
