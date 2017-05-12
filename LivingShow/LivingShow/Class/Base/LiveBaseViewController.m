//
//  LiveBaseViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveBaseViewController.h"

@interface LiveBaseViewController ()

@end

@implementation LiveBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 生成随机颜色
    self.view.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
