//
//  EDAnimationLoginView.m
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDAnimationLoginView.h"
#import "EDLoginAdView.h"
#import "EDGradientButton.h"

@interface EDAnimationLoginView ()

@property (nonatomic, strong) EDLoginAdView *loginAdView;
@property (nonatomic, strong) UIImageView *loginLogoView;
@property (nonatomic, strong) UIButton *dismissBtn;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) EDGradientButton *loginBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;

@end

@implementation EDAnimationLoginView

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
        [self initSubViews];
    }
    return self;
}

#pragma mark -
#pragma mark --------view life cycle--------
- (UIButton *)dismissBtn
{
    if (_dismissBtn == nil) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(12, 12, 44, 44);
        [_dismissBtn setImage:[UIImage imageNamed:@"dismiss_newLogIn"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(self.frame.size.width-80, 12, 60, 44);
//        [_registerBtn setImage:[UIImage imageNamed:@"dismiss_newLogIn"] forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerBtn addTarget:self action:@selector(registerAccountAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIImageView *)loginLogoView
{
    if (_loginLogoView == nil) {
        _loginLogoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 88, 56, 56)];
        _loginLogoView.center = CGPointMake(self.frame.size.width/2, _loginLogoView.center.y);

        _loginLogoView.image = [UIImage imageNamed:@"logo_login"];
    }
    return _loginLogoView;
}

- (EDLoginAdView *)loginAdView
{
    if (_loginAdView == nil) {
        NSArray *dataSource = @[[UIImage imageNamed:@"0_loginAd"],[UIImage imageNamed:@"1_loginAd"],[UIImage imageNamed:@"2_loginAd"]];
        _loginAdView = [[EDLoginAdView alloc]initWithFrame:CGRectMake(0, self.loginLogoView.frame.origin.y+self.loginLogoView.frame.size.height+30, 250, 250) dataSource:dataSource];
        _loginAdView.center = CGPointMake(self.frame.size.width/2, _loginAdView.center.y);

        _loginAdView.backgroundColor = [UIColor whiteColor];
    }
    return _loginAdView;
}

- (EDGradientButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[EDGradientButton alloc]initWithFrame:CGRectMake(20, self.frame.size.height-120, self.frame.size.width-40, 50) startColor:[UIColor orangeColor] endColor:[UIColor redColor]];
        [_loginBtn setTitle:@"手机号登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)wechatLoginBtn
{
    if (_wechatLoginBtn == nil) {
        _wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatLoginBtn.frame = CGRectMake(self.frame.size.width/2-50, self.frame.size.height-70, 100, 44);
        //        [_wechatLoginBtn setImage:[UIImage imageNamed:@"dismiss_newLogIn"] forState:UIControlStateNormal];
        [_wechatLoginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_wechatLoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
        _wechatLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_wechatLoginBtn addTarget:self action:@selector(wechatLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatLoginBtn;
}



- (void)initSubViews
{
    [self addSubview:self.dismissBtn];
    [self addSubview:self.registerBtn];
    [self addSubview:self.loginLogoView];
    [self addSubview:self.loginAdView];
    [self addSubview:self.loginBtn];
    [self addSubview:self.wechatLoginBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark -
#pragma mark --------private methods--------
- (void)dismissViewAction
{
    [self operationWithActionType:EDLoginActionTypeDismiss];
}

- (void)registerAccountAction
{
    [self operationWithActionType:EDLoginActionTypeRegister];

}

- (void)loginAction
{
    [self operationWithActionType:EDLoginActionTypeMobileLogin];
}

- (void)wechatLoginAction
{
    [self operationWithActionType:EDLoginActionTypeWechatLogin];
}

- (void)operationWithActionType:(EDLoginActionType)actionType
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:didSelectActionType:)]) {
        [self.delegate loginView:self didSelectActionType:actionType];
    }
}

- (void)dealloc
{
    
}

@end
