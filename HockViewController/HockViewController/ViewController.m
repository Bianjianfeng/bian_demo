//
//  ViewController.m
//  HockViewController
//
//  Created by bianjianfeng on 2017/4/24.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Hock.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"2222");
}

- (void)methodAfterViewDidLoad
{
    NSLog(@"11111");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
