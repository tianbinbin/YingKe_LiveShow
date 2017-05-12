//
//  LiveMainTopView.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger idx);

@interface LiveMainTopView : UIView

@property (nonatomic, copy) MainTopBlock block;

- (instancetype)initWithFrame:(CGRect)frame Arr:(NSArray *)arr;

-(void)scrolling:(NSInteger)idx;

@end
