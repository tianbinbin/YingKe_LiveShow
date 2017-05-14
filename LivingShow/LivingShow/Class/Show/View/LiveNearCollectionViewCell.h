//
//  LiveNearCollectionViewCell.h
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveNearCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LiveLiew * live;

- (void)showAnimation;

@end
