//
//  EDLocationService.h
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/28.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/**
 获取定位成功block
 */
typedef void(^LocationServiceUpdateLocationSuccessBlock)(CLLocation *userLocation);


/**
 获取定位失败block
 
 @param errorMsg 定位失败原因
 */
typedef void(^LocationServiceUpdateLocationFailBlock)(NSString *errorMsg);

typedef void(^LocationServiceStopBlock)();


@interface EDLocationService : NSObject

/**
 创建定位服务单例
 */
+ (instancetype)shareService;

/**  用户地理位置  */
@property (nonatomic, strong) CLLocation *userLocation;


/**
 开始定位
 
 @param failBlock 失败回调
 */
+ (void)startLocationService:(LocationServiceUpdateLocationSuccessBlock)successBlock
                  errorBlock:(LocationServiceUpdateLocationFailBlock)failBlock
                   stopBlock:(LocationServiceStopBlock)stopBlock;

+ (void)stopLocationService;

/**  定位地址回调block  */
@property (nonatomic, strong) LocationServiceUpdateLocationSuccessBlock locationBlock;

/**  定位失败回调block  */
@property (nonatomic, strong) LocationServiceUpdateLocationFailBlock failBlock;

/** 定位停止回调block  */
@property (nonatomic, strong) LocationServiceStopBlock stopBlock;


@end
