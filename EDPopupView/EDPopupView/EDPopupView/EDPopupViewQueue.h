//
//  EDPopupViewQueue.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/18.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDPopupView;

@interface EDPopupViewQueue : NSObject

/**  popup views  */
@property (nonatomic, strong) NSMutableArray *popupViews;

+ (EDPopupViewQueue *)sharedQueue;

- (void)addPopupView:(EDPopupView *)popupView;

- (void)removePopupView:(EDPopupView *)popupView;

- (void)removeAllPopupViews;

@end
