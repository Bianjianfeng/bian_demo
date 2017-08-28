//
//  ViewController.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"
#import "EDAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 120, 120);
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showPopupView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertBtn.frame = CGRectMake(100, 300, 120, 120);
    [alertBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [alertBtn setTitle:@"测试" forState:UIControlStateNormal];
    [alertBtn addTarget:self action:@selector(showAlertController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];    
}

- (void)showPopupView:(id)sender
{
//    [EDAlertView showWithTitle:@"测试" message:@"你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大" cancelTitle:@"取消" completionBlock:^(EDPopupView *view, NSInteger buttonIndex) {
//        NSLog(@"选中%d",buttonIndex);
//    } otherTitles:@"确定1",@"确定2",@"确定3", nil];
//    [EDAlertView showWithTitle:@"测试" message:@"你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大" cancelTitle:@"取消" completionBlock:^(EDPopupView *view, NSInteger buttonIndex) {
//        NSLog(@"选中%d",buttonIndex);
//    } otherTitles:@"确定1",@"确定2", nil];
    [EDAlertView showWithTitle:@"测试" message:@"你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷" cancelTitle:nil contentView:nil completionBlock:^(EDPopupView *view, NSInteger buttonIndex) {
        NSLog(@"选中%d",buttonIndex);
    } otherTitleList:@[@"1",@"2",@"3"]];
    
//    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 270, 40)];
//    textField.placeholder = @"请输入手机号";
//    
//    [EDAlertView showWithTitle:@"提示" message:nil cancelTitle:@"确定" contentView:textField completionBlock:^(EDPopupView *popupView, NSInteger buttonIndex) {
//        NSLog(@"%@",textField.text);
//    } otherTitles:nil, nil];
    
}

- (void)showAlertController:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIAlertController测试" message:@"你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大爷你大" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
