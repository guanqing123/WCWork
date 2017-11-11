//
//  WCCheckAttendenceTool.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCheckAttendenceTool.h"
#import "MJExtension.h"
#import "WCHttpTool.h"

@implementation WCCheckAttendenceTool

+ (void)checkAttendenceWithParam:(WCCheckAttendenceParam *)checkAttendenceParam success:(void (^)(WCCheckAttendenceResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[checkAttendenceParam.appseq,checkAttendenceParam.trcode,checkAttendenceParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : checkAttendenceParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCCheckAttendenceResult *result = [WCCheckAttendenceResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            WCCheckAttendenceResult *result = [WCCheckAttendenceResult errorMsg:[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)didCheckAttendenceWithParam:(WCDidCheckAttendenceParam *)didCheckAttendenceParam success:(void (^)(WCDidCheckAttendenceResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[didCheckAttendenceParam.appseq,didCheckAttendenceParam.trcode,didCheckAttendenceParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : didCheckAttendenceParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCDidCheckAttendenceResult *result = [WCDidCheckAttendenceResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            result.signTime = [[json objectForKey:@"header"] objectForKey:@"trdate"];
            success(result);
        }else{
            WCDidCheckAttendenceResult *result = [WCDidCheckAttendenceResult errorMsg:[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
