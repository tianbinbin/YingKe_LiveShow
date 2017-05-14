//
//  LiveLiveHandler.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveLiveHandler.h"
#import "MJExtension.h"

@implementation LiveLiveHandler

// 获取热门直播信息
+(void)exexuteGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FaildedBlock)failed
{
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if([json[@"dm_error"] integerValue]){
        
            failed(json[@"error_msg"]);
        }
        else
        {
            success(json);
        }
        
        
    } failure:^(NSError *error) {
        
        failed(error);
    }];
}

+ (void)executeNearLiveTaskWithSuccess:(SuccessBlock)success
                                failed:(FaildedBlock)failed{
    
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":@"40.090562",
                              @"longitude":@"116.413353"
                              };
    
    [HttpTool getWithPath:API_NearLocation params:params success:^(id json) {
        
        
        NSInteger error = [json[@"dm_error"] integerValue];
        
        if (!error) {
            
            NSArray * lives = [LiveLiew mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
            
        } else {
            
            failed(json);
            
        }

    } failure:^(NSError *error) {
        
        failed(error);
    }];
}


+ (void)executeGetAdvertiseWithSuccess:(SuccessBlock)success
                                failed:(FaildedBlock)failed {
    
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        NSDictionary * resources = json[@"resources"][0];
        SXTAdvertise * ad = [SXTAdvertise mj_objectWithKeyValues:resources];
        success(ad);
        
    } failure:^(NSError *error) {
        
    }];
}


@end
