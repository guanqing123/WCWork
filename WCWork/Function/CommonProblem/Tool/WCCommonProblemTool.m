//
//  WCCommonProblemTool.m
//  WCWork
//
//  Created by information on 2017/10/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCommonProblemTool.h"
#import "MJExtension.h"
#import "WCHttpTool.h"

@implementation WCCommonProblemTool

+ (NSMutableArray *)jsonArrayToModelArray:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        WCCommonProblem *model = [WCCommonProblem commonProblemWithDict:dict];
        [tempArray addObject:model];
    }
    return tempArray;
}

+ (void)commomProblemWithParam:(WCCommonProbleParam *)commonProblemParam success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[commonProblemParam.appseq,commonProblemParam.trcode,commonProblemParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : commonProblemParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:XKURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSArray *result = [self jsonArrayToModelArray:[json objectForKey:@"data"]];
            success(result);
        }else{
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
