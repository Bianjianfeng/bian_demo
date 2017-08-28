//
//  EDGradientButton.h
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/12.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDGradientButton : UIButton

/**  start color  */
@property (nonatomic, strong) UIColor *startColor;

/**  end color  */
@property (nonatomic, strong) UIColor *endColor;

- (instancetype)initWithFrame:(CGRect)frame
                   startColor:(UIColor *)startColor
                     endColor:(UIColor *)endColor;

@end
