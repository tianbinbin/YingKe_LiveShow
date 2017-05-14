//
//  LiveLiveHandler.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveLiveHandler.h"


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

@end
