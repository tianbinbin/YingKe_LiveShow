//
//  LiveTabBarViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveTabBarViewController.h"

@interface LiveTabBarViewController ()<LiveTabBarDelegate>

@property (nonatomic, strong) LiveTabBar * tabbarView;         // 自定义的tabBar

@end

@implementation LiveTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载控制器
    [self configViewControllers];
    
    // 加载tabbar
    [self.tabBar addSubview:self.tabbarView];
    
    // 解决tabbar 的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
}

-(void)TabBar:(LiveTabBar *)tabbar ClickBtn:(LiveTabBarItemType)idx
{
    if(idx!=LiveTabBarItemTypeLaunch){
    
     self.selectedIndex = idx-LiveTabBarItemTypeLive;
        return;
    }
    
    // 开启模态视图
    LiveLaunchiewController * launchVC = [[LiveLaunchiewController alloc]init];
    [self presentViewController:launchVC animated:YES completion:^{
       
        
    }];
    
}

-(void)configViewControllers
{
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"LiveMainViewController",@"LiveMeViewController"]];
    
    for(NSInteger i =0;i<array.count;i++)
    {
        NSString * vcName = array[i];
        
        UIViewController * VC = [[NSClassFromString(vcName) alloc]init];
        LiveBaseNavViewController * nav = [[LiveBaseNavViewController alloc]initWithRootViewController:VC];
        
        [array replaceObjectAtIndex:i  withObject:nav];
        
    }
    
    self.viewControllers = array;
}


-(LiveTabBar *)tabbarView
{
    if(!_tabbarView)
    {
        _tabbarView = [[LiveTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _tabbarView.delegate = self;
        
    }
    return _tabbarView;
}



@end
