//
//  EDAlertButton.h
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/19.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDAlertButtonStyleModel;

typedef NS_ENUM(NSUInteger, EDAlertButtonStyle){
    EDAlertButtonStyleHorizontalTwoButtons, //平铺两个按钮
    EDAlertButtonStyleVerticalMoreButtons,  //垂直多个按钮
};

typedef NS_ENUM(NSUInteger, EDAlertOperationButtonStyle){
    EDAlertOperationButtonStyleNormal, //普通
    EDAlertOperationButtonStyleCancel,  //取消
};

@interface EDAlertButton : UIButton

@property (nonatomic, strong)EDAlertButtonStyleModel *buttonStyleModel;

+ (EDAlertButton *)buttonWithStyleModel:(EDAlertButtonStyleModel *)buttonStyleModel
                                 target:(id)target
                               selector:(SEL)selector;

@end


@interface EDAlertButtonStyleModel : NSObject

@property (nonatomic, strong) NSString *title;

/**  background color  */
@property (nonatomic, strong) UIColor *backgroundColor;
/**  borderWidth  */
@property (nonatomic, assign) CGFloat borderWidth;
/**  border color  */
@property (nonatomic, strong) UIColor *borderColor;
/**  title color  */
@property (nonatomic, strong) UIColor *titleColor;
/**  title font  */
@property (nonatomic, strong) UIFont *titleFont;
/**  cornerRadius */
@property (nonatomic, assign) CGFloat cornerRadius;

/**  button operation type */
@property (nonatomic, assign) EDAlertOperationButtonStyle operationStyle;


+ (EDAlertButtonStyleModel *)createStyleModelWithButtonStyle:(EDAlertButtonStyle)style;

+ (EDAlertButtonStyleModel *)cancelButtonStyleWithButtonStyle:(EDAlertButtonStyle)style;


@end
