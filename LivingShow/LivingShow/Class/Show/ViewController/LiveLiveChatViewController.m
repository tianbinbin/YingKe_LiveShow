//
//  LiveLiveChatViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveLiveChatViewController.h"

@interface LiveLiveChatViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *touxiang;

@end

@implementation LiveLiveChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.touxiang.layer.cornerRadius = 3;
    self.touxiang.clipsToBounds = YES;
}


@end
