//
//  WCHonourCompanyTool.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHonourCompanyTool.h"
#import "WCHttpTool.h"
#import "MJExtension.h"

@implementation WCHonourCompanyTool

+ (void)honourCompanyListWithParam:(WCHonourCompanyParam *)honourCompanyParam success:(void (^)(WCHonourCompanyResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[honourCompanyParam.appseq,honourCompanyParam.trcode,honourCompanyParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : honourCompanyParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCHonourCompanyResult *result = [WCHonourCompanyResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            success(nil);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
