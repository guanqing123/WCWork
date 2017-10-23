//
//  WCNewArrivalTool.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCNewArrivalTool.h"
#import "MJExtension.h"
#import "WCHttpTool.h"

@implementation WCNewArrivalTool

+ (void)newArrivalWithParam:(WCNewArrivalParam *)newArrivalParam success:(void (^)(WCNewArrivalResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[newArrivalParam.appseq,newArrivalParam.trcode,newArrivalParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : newArrivalParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:XKURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            WCNewArrivalResult *result = [WCNewArrivalResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            WCNewArrivalResult *result = [WCNewArrivalResult errorMsg:[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];

}

@end
