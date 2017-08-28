//
//  ViewController.m
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"
//#import "EDTransitionAdView.h"
#import "EDLoginAdView.h"
#import "EDGradientButton.h"

#import "LoginViewController.h"

@interface ViewController ()

//@property (nonatomic, strong)EDTransitionAdView *adView;
@property (nonatomic, strong) EDLoginAdView *adView;

@property (nonatomic, strong) EDGradientButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.adView.animationDuration = 5;
//    self.adView.dataSource = @[[UIImage imageNamed:@"521162"],[UIImage imageNamed:@"522080"]];
//    //    self.adView.dataSource = @[[UIImage imageNamed:@"0_loginAd"],[UIImage imageNamed:@"1_loginAd"],[UIImage imageNamed:@"2_loginAd"]];
//
//    [self.view addSubview:self.adView];
    
    [self.view addSubview:self.loginBtn];
}

- (void)loginAccountAction
{
    LoginViewController *controller = [LoginViewController new];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (EDLoginAdView *)adView
{
    if (!_adView) {
        _adView = [[EDLoginAdView alloc]initWithFrame:CGRectMake(60, 100, 200, 200)];
        _adView.backgroundColor = [UIColor whiteColor];
    }
    return _adView;
}

- (EDGradientButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[EDGradientButton alloc]initWithFrame:CGRectMake(100, 400, 200, 40) startColor:[UIColor orangeColor] endColor:[UIColor redColor]];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_loginBtn addTarget:self action:@selector(loginAccountAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
