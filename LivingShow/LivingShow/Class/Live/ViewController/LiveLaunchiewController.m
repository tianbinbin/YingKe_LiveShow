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
    
    UIView * back = [[UIView alloc] initWithFrame:self.view.bounds];
    back.backgroundColor = [UIColor blackColor];
    [self.view addSubview:back];
    
    // 开始直播
    LFLivePreview * liveView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:liveView];

    
    
}

@end
