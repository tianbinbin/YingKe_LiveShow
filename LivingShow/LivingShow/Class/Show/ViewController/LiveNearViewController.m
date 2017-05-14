//
//  LiveNearViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveNearViewController.h"

#define kItemSizeW 100
#define kMargin 5
static NSString * identifier = @"LiveNearCollectionViewCell";

@interface LiveNearViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray * dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LiveNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self.collectionView registerNib:[UINib nibWithNibName:@"LiveNearCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    [self loadData];
    
}



-(void)loadData
{
    [LiveLiveHandler executeNearLiveTaskWithSuccess:^(id obj) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",obj);
            
            self.dataList = obj;
            [self.collectionView reloadData];
        });

        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
    }];
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat outInset = self.view.width - 2 * kMargin;
    NSInteger count = outInset / kItemSizeW;
    NSInteger extraTotal = (NSInteger)(outInset - kMargin * (count - 1 ));
    
    CGFloat itemWH;
    
    if (extraTotal < count * kItemSizeW) {
        
        itemWH = extraTotal / count;
        
    } else {
        
        CGFloat extraWidth = extraTotal % kItemSizeW;
        itemWH = kItemSizeW + extraWidth / count;
    }
    
    return CGSizeMake(itemWH, itemWH + 25);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveNearCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LivePlayerViewController * playerVC = [[LivePlayerViewController alloc] init];
    
//    LiveLiew * live  = self.dataList[indexPath.row];
    
    playerVC.urlStr = @"rtmp://live.hkstv.hk.lxdns.com/live/hks";
    
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveNearCollectionViewCell * c = (LiveNearCollectionViewCell *)cell;
    [c showAnimation];
}


@end
