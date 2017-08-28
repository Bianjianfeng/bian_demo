//
//  EDPopupViewConfig.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/18.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDPopupViewConfig.h"

@implementation EDPopupViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentWidth = 275.;
        self.cornerRadius = 8.0f;
        self.backgroundColor    = [ED_UIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.9];
        self.backgroundTapGesEnable = NO;
    }
    return self;
}

@end
