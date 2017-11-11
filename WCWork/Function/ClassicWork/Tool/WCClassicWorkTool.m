//
//  WCClassicWorkTool.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCClassicWorkTool.h"
#import "MJExtension.h"
#import "WCHttpTool.h"

@implementation WCClassicWorkTool

+ (void)classicWorkWithParam:(WCClassicWorkParam *)classicWorkParam success:(void (^)(WCClassicWorkResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[classicWorkParam.appseq,classicWorkParam.trcode,classicWorkParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : classicWorkParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCClassicWorkResult *result = [WCClassicWorkResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            WCClassicWorkResult *result = [WCClassicWorkResult errorMsg:[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
