//
//  LiveTabBar.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveTabBar.h"

@interface LiveTabBar ()

@property (nonatomic, strong) UIImageView * tabBarimageV;            // 背景图片
@property (nonatomic, strong) NSArray * datalist;                    // 数据源
@property (nonatomic, strong) UIButton * lastBtnItem;                // 记录上一个btn
@property (nonatomic, strong) UIButton * carmaBtn;                   // 相机

@end

@implementation LiveTabBar


-(NSArray *)datalist
{
    if(!_datalist)
    {
        _datalist = @[@"tab_live",@"tab_me"];
    }
    return _datalist;
}

-(UIImageView *)tabBarimageV
{
    if(!_tabBarimageV)
    {
        _tabBarimageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBarimageV;
}

-(UIButton *)carmaBtn
{
    if(!_carmaBtn)
    {
        _carmaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carmaBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        // 根据图片自适应大小
        [_carmaBtn sizeToFit];
        [_carmaBtn addTarget:self action:@selector(btnClickItem:) forControlEvents:UIControlEventTouchUpInside];
        _carmaBtn.tag = LiveTabBarItemTypeLaunch;
    }
    return _carmaBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 设置背景图
        [self addSubview:self.tabBarimageV];
        
        for (NSUInteger i = 0 ; i< self.datalist.count;i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClickItem:) forControlEvents:UIControlEventTouchUpInside];
            // 不让图片在高亮下改变
            btn.adjustsImageWhenHighlighted = NO;
            btn.tag = LiveTabBarItemTypeLive+i;
            
            if(i==0)
            {
                btn.selected = YES;
                self.lastBtnItem = btn;
            }
            [self addSubview:btn];
        }
        
        [self addSubview:self.carmaBtn];
    
    }
    return self;
}

-(void)btnClickItem:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(TabBar:ClickBtn:)])
    {
        [self.delegate TabBar:self ClickBtn:btn.tag];
    }
    
    !self.block ? : self.block(self,btn.tag);
    
    if(btn.tag == LiveTabBarItemTypeLaunch)
        return;
    
    self.lastBtnItem.selected = NO;
    btn.selected = YES;
    self.lastBtnItem = btn;
    
    // 设置动画
    [UIView animateWithDuration:0.2 animations:^{
        // 扩大1.2倍
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            // 恢复原始状态
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBarimageV.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width/self.datalist.count;
    
    for (NSInteger i = 0 ; i<self.subviews.count;i++)
    {  UIView * view =  [self subviews][i];
        if([view isKindOfClass:[UIButton class]])
        {
            view.frame = CGRectMake((view.tag-LiveTabBarItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    
    [self.carmaBtn sizeToFit];
    self.carmaBtn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-50);

}




@end
