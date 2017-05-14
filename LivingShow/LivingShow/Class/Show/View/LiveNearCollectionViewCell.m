//
//  LiveNearCollectionViewCell.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveNearCollectionViewCell.h"

@interface LiveNearCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;


@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation LiveNearCollectionViewCell

- (void)showAnimation {
    //x和y的最终值为1
    if (self.live.isShow) {
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:1 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.live.show = YES;
    }];
}

- (void)setLive:(LiveLiew *)live {
    
    _live = live;
    
    [self.headView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    self.distanceLabel.text = live.distance;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
