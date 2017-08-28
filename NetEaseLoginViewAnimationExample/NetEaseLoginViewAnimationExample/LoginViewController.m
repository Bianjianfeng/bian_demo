//
//  LoginViewController.m
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "LoginViewController.h"
#import "EDAnimationLoginView.h"

@interface LoginViewController ()<EDAnimationLoginViewDelegate>

@property (nonatomic, strong) EDAnimationLoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.loginView.frame = self.view.bounds;
}

- (EDAnimationLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[EDAnimationLoginView alloc]initWithFrame:self.view.bounds];
        _loginView.delegate = self;
        _loginView.backgroundColor = [UIColor whiteColor];
    }
    return _loginView;
}

- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark --------EDAnimationLoginViewDelegate--------
- (void)loginView:(EDAnimationLoginView *)loginView didSelectActionType:(EDLoginActionType)actionType
{
    switch (actionType) {
        case EDLoginActionTypeDismiss:
        {
            [self dismissController];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
