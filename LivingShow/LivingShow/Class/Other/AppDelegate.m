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
    
    [self setupUmeng];
    
    UIViewController * mainVC ;
    
    
    if ([SXTUserHelper isAutoLogin]) {
        
        mainVC = [[LiveTabBarViewController alloc] init];
        
    } else {
        mainVC = [[LiveloginViewController alloc] init];
        
    }

    self.window.rootViewController = mainVC;
    
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


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}




@end
