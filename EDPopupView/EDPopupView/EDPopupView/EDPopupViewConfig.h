//
//  EDPopupViewConfig.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/18.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ED_UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface EDPopupViewConfig : NSObject

/**  content width  */
@property (nonatomic, assign) CGFloat contentWidth;

/**
 alert content view cornerRadius default 8
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 default #FFFFFF
 */
@property (nonatomic, strong) UIColor *backgroundColor;


/**  background view tap dismiss enabled  */
@property (nonatomic, assign) BOOL backgroundTapGesEnable;

@end
