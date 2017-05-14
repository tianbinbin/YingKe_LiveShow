//
//  AppDelegate.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LiveTabBarViewController * mianVC = [[LiveTabBarViewController alloc]init];
    self.window.rootViewController = mianVC;
    
    // 获取经纬度
    [[LiveLocationManager shareManager]getGps:^(NSString *lat, NSString *lon) {
        
        NSLog(@"%@  %@",lat,lon);
        
    }];
    
    [self.window makeKeyAndVisible];
    //载入广告
    LiveAdvertisView * adverVC = [LiveAdvertisView loadAdvertiseView];
    [self.window addSubview:adverVC];
    
    return YES;
}





@end
