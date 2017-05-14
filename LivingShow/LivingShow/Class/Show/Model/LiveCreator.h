//
//  LiveCreator.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveCreator : NSObject

@property (nonatomic, strong) NSString * birth;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, strong) NSString * emotion;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger gmutex;
@property (nonatomic, strong) NSString * hometown;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, assign) NSInteger inkeVerify;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * nick;
@property (nonatomic, strong) NSString * portrait;
@property (nonatomic, strong) NSString * profession;
@property (nonatomic, assign) NSInteger rankVeri;
@property (nonatomic, strong) NSString * thirdPlatform;
@property (nonatomic, strong) NSString * veriInfo;
@property (nonatomic, assign) NSInteger verified;
@property (nonatomic, strong) NSString * verifiedReason;

@end
