//
//  WCAddressBookTool.m
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookTool.h"
#import "WCHttpTool.h"
#import "MJExtension.h"

@implementation WCAddressBookTool

+ (void)addressBookListWithParam:(WCAddressBookListParam *)addressBookListParam success:(void (^)(WCAddressBookListResult *result))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[addressBookListParam.appseq,addressBookListParam.trcode,addressBookListParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : addressBookListParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter timeoutInterval:@(120) success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCAddressBookListResult *result = [json objectForKey:@"data"];
            if (result) {
                success(result);
            }
        }else{
            WCAddressBookListResult *result = [WCAddressBookListResult dictionaryWithObject:[[json objectForKey:@"header"] objectForKey:@"errorcode"] forKey:@"errorcode"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
