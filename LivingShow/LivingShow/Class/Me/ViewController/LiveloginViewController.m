//
//  LiveloginViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveloginViewController.h"

@interface LiveloginViewController ()

@end

@implementation LiveloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)weibologin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
            [SXTUserHelper sharedUser].username = snsAccount.userName;
            [SXTUserHelper sharedUser].iconUrl = snsAccount.iconURL;
            //保存入本地
            [SXTUserHelper saveUser];
            
            self.view.window.rootViewController = [[LiveTabBarViewController alloc] init];
            
        } else {
            
            NSLog(@"登录失败");
        }
        
    });
}

- (IBAction)phonelogin:(id)sender {
    
    

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是不是美女？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    
    }];
    
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
     self.view.window.rootViewController = [[LiveTabBarViewController alloc] init];
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{
        
 
        
    }];

}

@end
