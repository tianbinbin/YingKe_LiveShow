//
//  LiveLaunchiewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveLaunchiewController.h"

@interface LiveLaunchiewController ()

@end

@implementation LiveLaunchiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)StartLiveBtn:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"一定要链接真机，不然会崩溃的" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }];
    
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        UIView * back = [[UIView alloc] initWithFrame:self.view.bounds];
        back.backgroundColor = [UIColor blackColor];
        [self.view addSubview:back];
        
        // 开始直播
        LFLivePreview * liveView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
        liveView.VC = self;
        [self.view addSubview:liveView];
        
       
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{
        
        
    }];

}

@end
