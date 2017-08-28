//
//  EDAlertView.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDPopupView.h"
#import "EDPopupViewConfig.h"
#import "EDAlertButton.h"
@interface EDAlertView : EDPopupView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                  contentView:(UIView *)contentView
                       buttons:(NSArray<EDAlertButtonStyleModel *> *)buttons;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          contentView:(UIView *)contentView
      completionBlock:(EDPopupCompletionBlock)block
       otherTitleList:(NSArray *)otherTitleList;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          contentView:(UIView *)contentView
      completionBlock:(EDPopupCompletionBlock)block
          otherTitles:(NSString *)otherTitles,...NS_REQUIRES_NIL_TERMINATION;
@end


@interface EDAlertViewConfig : EDPopupViewConfig

/**
 default 44
 */
@property (nonatomic, assign) CGFloat buttonHeight;
/**
 default 9
 */
@property (nonatomic, assign) CGFloat marginHeight;
/**
 default 17
 */
@property (nonatomic, assign) CGFloat titleFontSize;
/**
 default 15
 */
@property (nonatomic, assign) CGFloat messageFontSize;
/**
 default #000000
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 default #000000
 */
@property (nonatomic, strong) UIColor *messageTextColor;

+ (EDAlertViewConfig *)sharedConfig;

@end
