//
//  ScanAnimationView.h
//  Test
//
//  Created by bianjianfeng on 16/4/18.
//  Copyright © 2016年 bianjianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kDefaultAnimateDuration = 1.5f;

static NSString* const kDefaultAnimateKey = @"scanAnimate";

@interface ScanAnimationView : UIView
/**
 *  扫码动画
 *
 *  @since 1.0
 */
@property (strong, nonatomic) UIImage *scanImage;
/**
 *  扫码持续时间
 *
 *  @since 1.0
 */
@property (assign, nonatomic) CGFloat duration;
//@property (assign, nonatomic) BOOL repeat;

/**
 *  开始动画
 *
 *  @since 1.0
 */
- (void)startAnimate;

/**
 *  停止动画
 *
 *  @since 1.0
 */
- (void)stopAnimate;

@end
