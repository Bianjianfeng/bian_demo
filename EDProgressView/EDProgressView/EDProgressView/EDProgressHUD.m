//
//  EDProgressHUD.m
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDProgressHUD.h"
#import "EDActivityIndicatorView.h"

@interface EDProgressHUD ()

@property (nonatomic, strong)EDActivityIndicatorView *progressView;

@end

@implementation EDProgressHUD

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static EDProgressHUD *progressHUD;
    
    dispatch_once(&once, ^{
        progressHUD = [[EDProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
        progressHUD.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        
        EDActivityIndicatorView *progressView = [[EDActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
        progressView.progressType = EDCircularProgressViewTypePulldownRefresh;
        progressView.center          = CGPointMake(progressHUD.frame.size.width/2, progressHUD.frame.size.height/2);
        [progressHUD addSubview:progressView];
        progressHUD.progressView = progressView;
        
    });
    return progressHUD;
}

+ (void)showHud
{
    EDProgressHUD *hud = [EDProgressHUD shareInstance];
    if (hud.progressView.animating)return;
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    [hud.progressView startAnimating];

}

+ (void)dismissHud
{
    EDProgressHUD *hud    = [EDProgressHUD shareInstance];
    [hud.progressView stopAnimating];
    [hud removeFromSuperview];
}

@end
