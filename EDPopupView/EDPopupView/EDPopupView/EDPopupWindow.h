//
//  EDPopupWindow.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDPopupWindow : UIWindow

@property (nonatomic, readonly) UIView* attachView;

@property (nonatomic, readonly) UIViewController* rootVC;

/**  backgroud view  */
@property (nonatomic, strong) UIView *backgroudView;

+ (EDPopupWindow *)sharedWindow;

- (void)showBackgroundView;
- (void)hideBackgroundView;
@end
