//
//  EDCircularProgressView.h
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EDCircularProgressViewType) {
    EDCircularProgressViewTypeHUD,
    EDCircularProgressViewTypePulldownRefresh,
};

#define kUIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface EDCircularProgressView : UIView

/**  progress  */
@property (nonatomic, assign) float progress;

/**
 layer line width default 2.0
 */
@property (nonatomic, assign) CGFloat lineWidth;
/**
 animate duration default 0.3
 */
@property (nonatomic, assign) CFTimeInterval animationDuration;

/**  进度条颜色  */
@property (nonatomic, strong) UIColor *progressColor;


/**  UIBezierPath  */
@property (nonatomic, strong) UIBezierPath *bPath;

/**  type  */
@property (nonatomic, assign) EDCircularProgressViewType progressViewType;


- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
