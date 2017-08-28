//
//  EDGradientButton.m
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/12.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDGradientButton.h"

@interface EDGradientButton ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation EDGradientButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
                   startColor:(UIColor *)startColor
                     endColor:(UIColor *)endColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsTouchWhenHighlighted = YES;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(0, 0.5);

        _startColor = startColor;
        _endColor = endColor;
        [self updateGradientImage];
    }
    return self;
}



//- (void)commonInit
//{
//    self.gradientLayer = [CAGradientLayer layer];
//    self.gradientLayer.frame = self.layer.bounds;
//    self.gradientLayer.zPosition = -1;
//
//    self.gradientLayer.colors = [NSArray arrayWithObjects:
//                            (id)_startColor.CGColor,
//                            (id)_endColor.CGColor,
//                            nil];
//    
//    self.gradientLayer.locations = [NSArray arrayWithObjects:
//                               [NSNumber numberWithFloat:0.0f],
//                               [NSNumber numberWithFloat:1.0f],
//                               nil];
//    self.gradientLayer.startPoint = CGPointMake(0, 0);
//    
//    // 结束点
//    self.gradientLayer.endPoint   = CGPointMake(1, 0);
//    self.gradientLayer.cornerRadius = self.layer.cornerRadius;
//    [self.layer addSublayer:self.gradientLayer];
//}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    [self updateGradientImage];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self updateGradientImage];
}

- (void)updateGradientImage
{
    [self setBackgroundImage:[self gradientImage] forState:UIControlStateNormal];
}

- (UIImage *)gradientImage
{
    if (_startColor == nil) {
        _startColor = self.backgroundColor;
    }
    if (_endColor == nil) {
        _endColor = self.backgroundColor;
    }
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[(__bridge id)_startColor.CGColor,   // start color
                     (__bridge id)_endColor.CGColor]; // end color
    layer.colors = [NSArray arrayWithObjects:
                                 (id)_startColor.CGColor,
                                 (id)_endColor.CGColor,
                                 nil];
    layer.locations = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0f],
                                    [NSNumber numberWithFloat:1.0f],
                                    nil];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint   = CGPointMake(1, 0);

    UIGraphicsBeginImageContext(size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
