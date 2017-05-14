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

@end
