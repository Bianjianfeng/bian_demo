//
//  EDPopupView.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDPopupView;

typedef NS_ENUM(NSUInteger, EDPopupType){
    EDPopupTypeAlert,
    EDPopupTypeCustom,
};

typedef void(^EDPopupCompletionBlock)(EDPopupView* ,NSInteger buttonIndex);


@interface EDPopupView : UIView

/**  default is NO  */
@property (nonatomic, assign) BOOL visible;

/**  attended view default screen window  */
@property (nonatomic, strong) UIView *attachedView;

/**  popup type default is  EDPopupTypeAlert*/
@property (nonatomic, assign) EDPopupType  popupType;

/**  show hidden animation duratiom default is 0.3 sec */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**  hidden completion block  */
@property (nonatomic, copy) EDPopupCompletionBlock hiddenCompletionBlock;


/**
 show popup view
 */
- (void)show;

/**
 hidden popup view
 */
- (void)hide;

- (void)moveToFront;
- (void)moveToBackgroud;


///**
// hidden all popup view in the window
// */
//+ (void)hideAll;


@end
