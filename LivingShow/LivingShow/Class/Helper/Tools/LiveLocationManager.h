//
//  LiveLocationManager.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString * lat ,NSString * lon);

@interface LiveLocationManager : NSObject

+(instancetype)shareManager;

-(void)getGps:(LocationBlock)block;

@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lon;

@end
