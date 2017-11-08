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
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSArray *result = [WCSliderResult mj_objectArrayWithKeyValuesArray:[[json objectForKey:@"data"] objectForKey:@"list"]];
            success(result);
        }else{
            success([NSArray array]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)homeSectionHeaderViewParam:(WCSectionHeaderViewParam *)sectionHeaderViewParam success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[sectionHeaderViewParam.appseq,sectionHeaderViewParam.trcode,sectionHeaderViewParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : sectionHeaderViewParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]){
            NSDictionary *dict = [json objectForKey:@"data"];
            if ([[dict objectForKey:@"RRRR_STATUS"] isEqualToString:@"SUCCESS"]) {
                NSArray *result = [WCSectionHeaderViewResult mj_objectArrayWithKeyValuesArray:[[dict objectForKey:@"RRRR_DATA"] objectForKey:@"NewsColumn"]];
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

+ (void)homeDynamicWithParam:(WCDynamicParam *)dynamicParam success:(void (^)(WCDynamicResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[dynamicParam.appseq,dynamicParam.trcode,dynamicParam.trdate,dynamicParam.page,dynamicParam.columnId] forKeys:@[@"appseq",@"trcode",@"trdate",@"page",@"columnId"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : dynamicParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSDictionary *dict = [json objectForKey:@"data"];
            if ([[dict objectForKey:@"RRRR_STATUS"] isEqualToString:@"SUCCESS"]) {
                WCDynamicResult *result = [WCDynamicResult mj_objectWithKeyValues:[dict objectForKey:@"RRRR_DATA"]];
                success(result);
            }else{
                success([[WCDynamicResult alloc] init]);
            }
        }else{
            success([[WCDynamicResult alloc] init]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)dynamicDetailWithParam:(WCDynamicDetailParam *)dynamicDetailParam success:(void (^)(WCDynamicDetailResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[dynamicDetailParam.appseq,dynamicDetailParam.trcode,dynamicDetailParam.trdate,dynamicDetailParam.contentId] forKeys:@[@"appseq",@"trcode",@"trdate",@"contentId"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : dynamicDetailParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [WCHttpTool postWithURL:WCURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSDictionary *dict = [json objectForKey:@"data"];
            if ([[dict objectForKey:@"RRRR_STATUS"] isEqualToString:@"SUCCESS"]) {
                WCDynamicDetailResult *result = [WCDynamicDetailResult mj_objectWithKeyValues:[dict objectForKey:@"RRRR_DATA"]];
                success(result);
            }else{
                WCDynamicDetailResult *result = [[WCDynamicDetailResult alloc] init];
                result.Message = [NSString stringWithFormat:@"<p> RRRR_STATUS:%@ </p>",[dict objectForKey:@"RRRR_STATUS"]];
                success(result);
            }
        }else{
            WCDynamicDetailResult *result = [[WCDynamicDetailResult alloc] init];
            result.Message = [NSString stringWithFormat:@"<p> errorcode:%@ </p>",[[json objectForKey:@"header"] objectForKey:@"errorcode"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
