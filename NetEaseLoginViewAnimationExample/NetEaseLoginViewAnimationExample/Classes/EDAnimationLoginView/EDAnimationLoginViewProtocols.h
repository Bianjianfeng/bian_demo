//
//  EDAnimationLoginViewProtocols.h
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EDLoginActionType) {
    EDLoginActionTypeDismiss,
    EDLoginActionTypeMobileLogin,
    EDLoginActionTypeRegister,
    EDLoginActionTypeForgetPassword,
    EDLoginActionTypeWechatLogin,
};


@class EDAnimationLoginView;
@protocol EDAnimationLoginViewDelegate <NSObject>
@optional
- (void)loginView:(EDAnimationLoginView *)loginView didSelectActionType:(EDLoginActionType)actionType;
@end
