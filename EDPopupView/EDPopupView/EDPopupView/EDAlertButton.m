//
//  EDAlertButton.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/19.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDAlertButton.h"
#import "EDPopupViewConfig.h"

@implementation EDAlertButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (EDAlertButton *)buttonWithStyleModel:(EDAlertButtonStyleModel *)buttonStyleModel
                                 target:(id)target
                               selector:(SEL)selector
{
    EDAlertButton *button = [EDAlertButton buttonWithType:UIButtonTypeCustom];
    button.buttonStyleModel = buttonStyleModel;
    button.backgroundColor = buttonStyleModel.backgroundColor;
    [button setTitleColor:buttonStyleModel.titleColor forState:UIControlStateNormal];
    [button setTitle:buttonStyleModel.title forState:UIControlStateNormal];
    button.titleLabel.font = buttonStyleModel.titleFont;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    if (buttonStyleModel.cornerRadius > 0) {
        button.layer.cornerRadius = buttonStyleModel.cornerRadius;
    }
    
    if (buttonStyleModel.borderWidth > 0) {
        button.layer.borderWidth = buttonStyleModel.borderWidth;
    }
    if (buttonStyleModel.borderColor) {
        button.layer.borderColor = buttonStyleModel.borderColor.CGColor;
    }
    return button;
}


@end


@implementation EDAlertButtonStyleModel

+ (EDAlertButtonStyleModel *)createStyleModelWithButtonStyle:(EDAlertButtonStyle)style
{
    EDAlertButtonStyleModel *model = [EDAlertButtonStyleModel new];
    model.operationStyle = EDAlertOperationButtonStyleNormal;
    switch (style) {
        case EDAlertButtonStyleHorizontalTwoButtons:
        {
            model.backgroundColor = [UIColor clearColor];
            model.titleFont = [UIFont boldSystemFontOfSize:17];
            model.titleColor = [UIColor orangeColor];
        }
            break;
        case EDAlertButtonStyleVerticalMoreButtons:
        {
            model.backgroundColor = [UIColor clearColor];
            model.titleFont = [UIFont boldSystemFontOfSize:17];
            model.titleColor = [UIColor blackColor];
            model.borderWidth = 1;
            model.borderColor = [UIColor blackColor];
            model.cornerRadius = 8;
        }
            break;
        default:
            break;
    }
    
    return model;
}

+ (EDAlertButtonStyleModel *)cancelButtonStyleWithButtonStyle:(EDAlertButtonStyle)style
{
    EDAlertButtonStyleModel *model = [EDAlertButtonStyleModel new];
    model.operationStyle = EDAlertOperationButtonStyleCancel;
    switch (style) {
        case EDAlertButtonStyleHorizontalTwoButtons:
        {
            model.backgroundColor = [UIColor clearColor];
            model.titleFont = [UIFont systemFontOfSize:17];
            model.titleColor = [UIColor blackColor];
        }
            break;
        case EDAlertButtonStyleVerticalMoreButtons:
        {
            model.backgroundColor = [UIColor orangeColor];
            model.titleFont = [UIFont systemFontOfSize:17];
            model.titleColor = [UIColor whiteColor];
            model.cornerRadius = 8;
        }
            break;
        default:
            break;
    }
    
    return model;
}


@end
