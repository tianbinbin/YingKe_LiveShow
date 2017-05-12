//
//  LiveMainViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveMainViewController.h"


@interface LiveMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contenScrollView;
@property (nonatomic, strong) NSArray * datalist;                           // 标题库
@property (nonatomic, strong) LiveMainTopView * topView;                    // 标题头

@end

@implementation LiveMainViewController

-(NSArray *)datalist
{
    if(!_datalist)
    {
        _datalist = @[@"关注",@"热门",@"附近"];
    }
    return _datalist;
}

-(LiveMainTopView *)topView
{
    if(!_topView){
      
        _topView = [[LiveMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) Arr:self.datalist];
    
        __weak LiveMainViewController * weakself = self;
        
        _topView.block = ^(NSInteger tag){

            CGPoint point =  CGPointMake(tag*SCREEN_WIDTH, weakself.contenScrollView.contentOffset.y);
            [weakself.contenScrollView setContentOffset:point animated:YES];
        
        };
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    

}

-(void)initUI
{
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStylePlain target:self action:@selector(LeftItemClick:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:self action:@selector(RightItemClick:)];
    
    // 添加子试图控制器
    [self SetUpChildViewController];
    
}

-(void)SetUpChildViewController
{
    NSArray * vcNames = @[@"LiveFocusViewController",@"LiveHotViewController",@"LiveNearViewController"];
    
    for(NSInteger i =0 ;i<vcNames.count;i++)
    {
        NSString * vcName = vcNames[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc]init];
        vc.title = self.datalist[i];
        // 此时并没有走vc 的 viewdidload 方法 只是加载到视图控制器
        [self addChildViewController:vc];
    }
    
    // 添加子试图控制器的view 添加到scrollView 中

    // 设置scrollView 的contentSize
    self.contenScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.datalist.count, 0);
    
    // 默认展示第二个页面
    self.contenScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    // 进入主控制加载第一个界面
    [self scrollViewDidEndDecelerating:self.contenScrollView];

}

-(void)LeftItemClick:(UIBarButtonItem *)item
{
    
}

-(void)RightItemClick:(UIBarButtonItem *)item
{
    
}

#pragma mark  ----- scrollView delegate
// 减速结束之后加载子试图控制器
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 动画结束调用代理
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 每一个子试图控制器的宽度和高度
    CGFloat width = SCREEN_WIDTH;
    NSLog(@"tb----%@---%f",@(scrollView.frame.size.width),SCREEN_WIDTH);
    CGFloat height = SCREEN_HEIGHT;
    CGFloat offset = scrollView.contentOffset.x;
    
    NSInteger idx = offset/width;
    [self.topView scrolling:idx];
    
    UIViewController * vc = self.childViewControllers[idx];
    
    // 判断当前vc 是否执行过viewdidload
    if([vc isViewLoaded]) return;
    
    // 设置子试图控制器view 的大小 然后将子试图控制器的view 加载到scrollView
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    [scrollView addSubview:vc.view];
}




@end
