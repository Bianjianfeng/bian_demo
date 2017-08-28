//
//  EDPopupView.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDPopupView.h"
#import "EDPopupWindow.h"
#import "EDPopupViewQueue.h"
static NSTimeInterval const EDShowHideAnimationDuration = .3;

@interface EDPopupView ()

@end

@implementation EDPopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.popupType = EDPopupTypeAlert;
    self.animationDuration = EDShowHideAnimationDuration;
    self.attachedView = [EDPopupWindow sharedWindow].attachView;
}

- (void)hide
{
    [self alertHideAnimation];
}

- (void)show
{
    [[EDPopupViewQueue sharedQueue] addPopupView:self];
}

- (void)moveToFront
{
    [self alertShowAnimation];
}

- (void)moveToBackgroud
{
    [self removeFromSuperview];
}

- (void)alertShowAnimation
{
    if (!self.superview )
    {
        [self.attachedView addSubview:self];
        [[EDPopupWindow sharedWindow] makeKeyAndVisible];
        self.center = CGPointMake(self.attachedView.frame.size.width/2, self.attachedView.frame.size.height/2);
        [self.attachedView bringSubviewToFront:self];
        [self layoutIfNeeded];
    }
    
    self.visible = YES;

    [[EDPopupWindow sharedWindow] showBackgroundView];
    [self showAnimation];
}

- (void)alertHideAnimation
{
    if ([EDPopupViewQueue sharedQueue].popupViews.count == 1) {
        [self hideAnimation];
        [[EDPopupWindow sharedWindow] hideBackgroundView];
        [EDPopupWindow sharedWindow].hidden = YES;
        [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
        [[[[UIApplication sharedApplication] delegate]window]makeKeyAndVisible];
    }

    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.visible = NO;
        if (finished){
            [[EDPopupViewQueue sharedQueue] removePopupView:self];
            [self moveToBackgroud];
        }
    }];
}

- (void)showAnimation
{
    if (self.popupType == EDPopupTypeCustom) {
        [self showCustomAnimation];
    }else {
        [self showAlertAnimation];
    }
}

- (void)hideAnimation
{
    if (self.popupType == EDPopupTypeCustom) {
        [self dismissCustomAnimation];
    }else {
        [self dismissAlertAnimation];
    }
}

- (void)showAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [self.layer addAnimation:animation forKey:@"showAlert"];

}

- (void)dismissAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = self.animationDuration;
    
    [self.layer addAnimation:animation forKey:@"dismissAlert"];
}

- (void)showCustomAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [self.layer addAnimation:animation forKey:@"showCustom"];
}

- (void)dismissCustomAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = self.animationDuration;
    
    [self.layer addAnimation:animation forKey:@"dismissAlert"];
}

@end
