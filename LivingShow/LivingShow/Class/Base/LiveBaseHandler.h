//
//  LiveBaseHandler.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>

// 处理完成事件
typedef void(^CompleteBlock)();

// 处理事件成功 返回数据
typedef void(^SuccessBlock)(id obj);

// 处理事件失败 错误数据
typedef void(^FaildedBlock)(id obj);

@interface LiveBaseHandler : NSObject



@end
