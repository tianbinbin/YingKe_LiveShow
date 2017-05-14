//
//  LiveHotViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveHotViewController.h"

@interface LiveHotViewController ()

@property (nonatomic, strong) UITableView * tableview;


@end

@implementation LiveHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitUI];
    
    [self LoadData];
    
    
    
}

-(void)InitUI{

    [LiveLiveHandler exexuteGetHotLiveTaskWithSuccess:^(id obj) {
        
    } failed:^(id obj) {
        
    }];
}


-(void)LoadData{


}
- (IBAction)btncclick:(id)sender {
    
    LivePlayerViewController * palyerController =   [[LivePlayerViewController alloc]init];
    

    /*
     rtmp://live.hkstv.hk.lxdns.com/live/hks
     rtmp://www.planeta-online.tv:1936/live/channel_4
     rtmp://live.hkstv.hk.lxdns.com/live/hks 香港卫视
     rtmp://221.120.177.59/livestream/ucagm8kk 香港卫视精品台
     http://main.gslb.ku6.com/broadcast/sub?channel=910 酷六V音乐
     */
    
    palyerController.urlStr = @"rtmp://live.hkstv.hk.lxdns.com/live/hks";
//    palyerController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:palyerController animated:YES];
    
}



@end
