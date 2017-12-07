//
//  WCOverViewCompanyTool.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCOverViewCompanyTool.h"
#import "WCHttpTool.h"
#import "MJExtension.h"

@implementation WCOverViewCompanyTool

+ (void)overViewCompanyWithParam:(WCOverViewCompanyParam *)overViewCompanyParam success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[overViewCompanyParam.appseq,overViewCompanyParam.trcode,overViewCompanyParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : overViewCompanyParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSString *content = [[[json objectForKey:@"data"] objectForKey:@"list"] objectForKey:@"content"];
            success(content);
        }else{
            success([NSString stringWithFormat:@"errorcode:%@",[[json objectForKey:@"header"] objectForKey:@"errorcode"]]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
