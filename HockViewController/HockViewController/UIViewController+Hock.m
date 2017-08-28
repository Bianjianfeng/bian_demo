//
//  UIViewController+Hock.m
//  HockViewController
//
//  Created by bianjianfeng on 2017/4/24.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "UIViewController+Hock.h"
#import <objc/runtime.h>
@implementation UIViewController (Hock)

+ (void)load {
    [super load];
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    
    if (!class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (void)swizzlingViewDidLoad {
    [self swizzlingViewDidLoad];
    if ([self respondsToSelector:NSSelectorFromString(@"methodAfterViewDidLoad")]) {
        [self performSelectorOnMainThread:NSSelectorFromString(@"methodAfterViewDidLoad") withObject:nil waitUntilDone:YES];
    }
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
