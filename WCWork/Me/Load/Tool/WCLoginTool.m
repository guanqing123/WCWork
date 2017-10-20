//
//  WCLoginTool.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCLoginTool.h"
#import "WCHttpTool.h"
#import "MJExtension.h"

@implementation WCLoginTool

+ (void)loginWithParam:(WCLoginParam *)loginParam success:(void (^)(WCLoginResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[loginParam.appseq,loginParam.trcode,loginParam.trdate,loginParam.gh,loginParam.mm] forKeys:@[@"appseq",@"trcode",@"trdate",@"gh",@"mm"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : loginParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCLoginResult *result = [WCLoginResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            WCLoginResult *result = [WCLoginResult result];
            result.error = YES;
            result.errorMsg = [NSString stringWithFormat:@"errorcode:%@",[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)saveLoginAccount:(WCLoginAccount *)loginAccount {
    NSLog(@"WCAccountFile = %@",WCAccountFile);
    [NSKeyedArchiver archiveRootObject:loginAccount toFile:WCAccountFile];
}

@end
