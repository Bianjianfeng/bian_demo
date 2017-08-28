//
//  EDPopupWindow.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDPopupWindow.h"
#import "EDPopupView.h"

@interface EDPopupWindow ()
@property (nonatomic, strong)UIViewController *rootVC;
@end

@implementation EDPopupWindow

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
        self.windowLevel = UIWindowLevelAlert;
        
        self.rootVC = [UIViewController new];
        
        self.backgroudView = [[UIView alloc]initWithFrame:self.bounds];
        self.backgroudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.backgroudView.alpha = 0.;
        [self.rootVC.view addSubview:self.backgroudView];
        
        self.rootViewController = self.rootVC;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        gesture.cancelsTouchesInView = NO;
        [self.backgroudView addGestureRecognizer:gesture];

    }
    return self;
}

+ (EDPopupWindow *)sharedWindow
{
    static EDPopupWindow *window;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        window = [[EDPopupWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    
    return window;
}

- (void)actionTap:(UITapGestureRecognizer*)gesture
{
    for ( UIView *v in self.attachView.subviews )
    {
        if ( [v isKindOfClass:[EDPopupView class]])
        {
            EDPopupView *popupView = (EDPopupView*)v;
            if (popupView.visible) {
                [popupView hide];
            }
        }
    }
}

- (UIView *)attachView
{
    return self.rootViewController.view;
}

- (void)showBackgroundView
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [self tintColorDidChange];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroudView.alpha = 1;
    }];
}

- (void)hideBackgroundView
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [self tintColorDidChange];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroudView.alpha = 0;
    }];
}


@end
