//
//  LiveLocationManager.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LiveLocationManager.h"

@interface LiveLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locManager;
@property (nonatomic, copy) LocationBlock block;

@end

@implementation LiveLocationManager

+(instancetype)shareManager
{
    static LiveLocationManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _manager = [[LiveLocationManager alloc]init];
    });
    return _manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc]init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if(![CLLocationManager locationServicesEnabled])
        {
            NSLog(@"开启定位服务");
        }
        else
        {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if(status == kCLAuthorizationStatusNotDetermined )
            {
                [_locManager requestWhenInUseAuthorization];
            }
        }
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
// 获取到经纬度
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    
    NSLog(@"获取新的经纬度 经度%@",@(coor.latitude));
    NSLog(@"获取新的经纬度 围堵%@",@(coor.longitude));
    
    NSString * lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString * lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    
    [LiveLocationManager shareManager].lat = lat;
    [LiveLocationManager shareManager].lon = lon;
    self.block(lat,lon);
    
    [self.locManager startUpdatingLocation];

}


-(void)getGps:(LocationBlock)block
{
    self.block = block;
    
    [self.locManager startUpdatingLocation];
}


@end
