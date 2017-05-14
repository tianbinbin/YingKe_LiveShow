//
//  LiveLiveHandler.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveBaseHandler.h"

@interface LiveLiveHandler : LiveBaseHandler

+(void)exexuteGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FaildedBlock)failed;


//附近 的直播
+ (void)executeNearLiveTaskWithSuccess:(SuccessBlock)success
                                failed:(FaildedBlock)failed;



//下载广告
+ (void)executeGetAdvertiseWithSuccess:(SuccessBlock)success
                                failed:(FaildedBlock)failed;

@end
