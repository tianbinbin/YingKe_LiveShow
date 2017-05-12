//
//  LiveTabBar.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LiveTabBarItemType){

    LiveTabBarItemTypeLaunch = 10,            // 启动直播
    LiveTabBarItemTypeLive  = 100,            // 展示直播
    LiveTabBarItemTypeMe   ,                  // 我的
};

@class  LiveTabBar;

typedef void(^TabBlock)(LiveTabBar * tabbar,LiveTabBarItemType idx);

@protocol LiveTabBarDelegate <NSObject>

-(void)TabBar:(LiveTabBar *)tabbar ClickBtn:(LiveTabBarItemType)idx;

@end


@interface LiveTabBar : UIView

@property (nonatomic, weak) id<LiveTabBarDelegate> delegate;   // 协议
@property (nonatomic, copy) TabBlock block;                    // block 回调

@end
