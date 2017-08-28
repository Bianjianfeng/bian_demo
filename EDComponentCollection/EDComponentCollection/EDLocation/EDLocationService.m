//
//  EDLocationService.m
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/28.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDLocationService.h"

@interface EDLocationService ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation EDLocationService

/**
 创建定位服务单例
 */
+ (instancetype)shareService
{
    static dispatch_once_t once;
    
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

/**
 开始定位
 
 @param failBlock 失败回调
 */
+ (void)startLocationService:(LocationServiceUpdateLocationSuccessBlock)successBlock
                  errorBlock:(LocationServiceUpdateLocationFailBlock)failBlock
                   stopBlock:(LocationServiceStopBlock)stopBlock
{
    [EDLocationService shareService].locationBlock = successBlock;
    [EDLocationService shareService].failBlock = failBlock;
    [EDLocationService shareService].stopBlock = stopBlock;
    
    [[EDLocationService shareService] startUpdateLocation];
}

+ (void)stopLocationService
{
    [[EDLocationService shareService] stopUpdateLocation];
}

/**
 *  开始定位
 */
- (void)startUpdateLocation
{
    if (![CLLocationManager locationServicesEnabled]) {
        if (self.failBlock) {
            self.failBlock(@"未开启定位服务");
        }
        return;
    }
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdateLocation
{
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
    }
}

- (void)updateLocation:(CLLocation *)location
{
    [self stopUpdateLocation];
    self.userLocation = location;
    
    if (self.locationBlock) {
        self.locationBlock(location);
    }
}

#pragma mark -
#pragma mark --------CLLocationManagerDelegate--------
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self updateLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location  = [locations lastObject];
    [self updateLocation:location];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (self.failBlock) {
        self.failBlock(@"定位发生错误");
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    if (self.stopBlock) {
        self.stopBlock();
    }
}
@end
