//
//  ViewController.m
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"
#import "EDActivityIndicatorView.h"

#import "EDProgressHUD.h"

@interface ViewController ()

@property (nonatomic, strong) EDActivityIndicatorView *activityView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    _activityView = [[EDActivityIndicatorView alloc]initWithFrame:CGRectMake(100, 100, 64, 64)];
    [self.view addSubview:_activityView];
   
    
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation)];
    [_activityView addGestureRecognizer:ges];
    
    
    UITapGestureRecognizer *selfvewges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudShow)];
    [self.view addGestureRecognizer:selfvewges];

}

- (void)hudShow
{
    [EDProgressHUD showHud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EDProgressHUD dismissHud];
    });
}

- (void)startAnimation
{
    if (_activityView.animating) {
        [_activityView stopAnimating];
        return;
    }
    [_activityView startAnimating];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_activityView stopAnimating];
//    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
