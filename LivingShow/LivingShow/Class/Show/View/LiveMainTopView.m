//
//  LiveMainTopView.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveMainTopView.h"

@interface LiveMainTopView ()

@property (nonatomic, strong) UIView * lineView;            // 滑动的线
@property (nonatomic, strong) NSMutableArray * buttons;     // 作为中间变量

@end

@implementation LiveMainTopView

-(NSMutableArray *)buttons
{
    if(!_buttons)
    {
        _buttons =[NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame Arr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat BtnW = self.frame.size.width/arr.count;
        CGFloat BtnH = self.frame.size.height;
        
        for(NSInteger i =0 ;i<arr.count;i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString * nameStr = arr[i];
            [btn setTitle:nameStr forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            btn.frame = CGRectMake(i*BtnW, 0, BtnW, BtnH);
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [self addSubview:btn];
            [self.buttons addObject:btn];
            
            // 设置线
            if(i == 1)
            {
                CGFloat lineH = 2;
                CGFloat lineY = 40;
                [btn.titleLabel sizeToFit];
                self.lineView = [[UIView alloc]init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.width = btn.titleLabel.width;
                self.lineView.top = lineY;
                self.lineView.height = lineH;
                CGPoint point =  self.lineView.center ;
                point.x = btn.center.x;
                self.lineView.center = point;
                [self addSubview:self.lineView];
            }
        }
        
    }
    return self;
}

// btn 点击事件
-(void)BtnClick:(UIButton *)btn
{
    !self.block ? : self.block(btn.tag);
    
    [self scrolling:btn.tag];
}

// 滑动事件
-(void)scrolling:(NSInteger)idx
{
    [UIView animateWithDuration:0.5 animations:^{
        UIButton * btn = self.buttons[idx];
        CGPoint point =  self.lineView.center ;
        point.x = btn.center.x;
        self.lineView.center = point;
        
    }];
}

@end
