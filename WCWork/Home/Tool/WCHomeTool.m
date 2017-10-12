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

@end
