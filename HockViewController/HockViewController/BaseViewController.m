//
//  BaseViewController.m
//  HockViewController
//
//  Created by bianjianfeng on 2017/4/24.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+Hock.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)viewWillLayoutSubviews
{
    
}

- (void)methodAfterViewDidLoad
{
    NSLog(@"root");
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