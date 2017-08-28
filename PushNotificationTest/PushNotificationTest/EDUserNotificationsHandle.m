//
//  EDUserNotificationsHandle.m
//  PushNotificationTest
//
//  Created by bianjianfeng on 2017/8/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDUserNotificationsHandle.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

@interface EDUserNotificationsHandle ()<UNUserNotificationCenterDelegate>
@end

#endif


@implementation EDUserNotificationsHandle

@end
