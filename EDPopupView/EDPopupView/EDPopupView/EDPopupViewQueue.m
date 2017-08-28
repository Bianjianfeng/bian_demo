//
//  EDPopupViewQueue.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/18.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDPopupViewQueue.h"
#import "EDPopupView.h"

@implementation EDPopupViewQueue

+ (EDPopupViewQueue *)sharedQueue
{
    static EDPopupViewQueue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EDPopupViewQueue alloc] init];
    });
    
    return sharedInstance;
}

- (NSMutableArray *)popupViews
{
    if (!_popupViews) {
        _popupViews = [[NSMutableArray alloc]init];
    }
    return _popupViews;
}


- (void)addPopupView:(EDPopupView *)popupView
{
    [self.popupViews addObject:popupView];
    [popupView moveToFront];
    for (EDPopupView *view in self.popupViews) {
        if (view != popupView) {
            [view moveToBackgroud];
        }
    }
}

- (void)removePopupView:(EDPopupView *)popupView
{
    [self.popupViews removeObject:popupView];
    if (self.popupViews.count > 0) {
        EDPopupView *popView = [self.popupViews lastObject];
        if (popView) {
            [popView moveToFront];
        }
    }
}

- (void)removeAllPopupViews
{
    for (EDPopupView *view in self.popupViews) {
        [view moveToBackgroud];
    }
    [self.popupViews removeAllObjects];
}

@end
