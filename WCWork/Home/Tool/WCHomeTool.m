//
//  WCHomeTool.m
//  WCWork
//
//  Created by information on 2017/10/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHomeTool.h"
#import "WCHttpTool.h"
#import "MJExtension.h"

@implementation WCHomeTool

+ (void)homeSliderWithParam:(WCSliderParam *)sliderParam success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[sliderParam.appseq,sliderParam.trcode,sliderParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : sliderParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:XKURL params:parameter success:^(id json) {
        if (success) {
            NSArray *dictArray = [[json objectForKey:@"data"] objectForKey:@"list"];
            NSArray *result = [WCSliderResult mj_objectArrayWithKeyValuesArray:dictArray];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)homeDynamicWithParam:(WCDynamicParam *)dynamicParam success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[dynamicParam.appseq,dynamicParam.trcode,dynamicParam.trdate,dynamicParam.page,dynamicParam.columnId] forKeys:@[@"appseq",@"trcode",@"trdate",@"page",@"columnId"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : dynamicParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSDictionary *dict = [json objectForKey:@"data"];
            if ([[dict objectForKey:@"RRRR_STATUS"] isEqualToString:@"SUCCESS"]) {
                NSArray *result = [WCDynamicResult mj_objectArrayWithKeyValuesArray:[[dict objectForKey:@"RRRR_DATA"] objectForKey:@"NewsList"]];
                success(result);
            }else{
                success([NSArray array]);
            }
        }else{
            success([NSArray array]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
