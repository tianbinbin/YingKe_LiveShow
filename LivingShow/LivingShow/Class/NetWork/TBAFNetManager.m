//
//  TBAFNetManager.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "TBAFNetManager.h"
#import "AFNetworking.h"

@interface TBAFNetManager ()

@end

@implementation TBAFNetManager

// 创建单例
+(instancetype)ShareClient
{
    static TBAFNetManager * AFNClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
    });
    return AFNClient;
}









@end
