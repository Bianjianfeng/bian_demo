//
//  MutableParamClass.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/20.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "MutableParamClass.h"

NSArray *getMutableParamList(NSString *paramsStr,...){
    
    va_list arguments;
    NSMutableArray *otherTitleList = [NSMutableArray new];
    if (paramsStr) {
        [otherTitleList addObject:paramsStr];
        va_start(arguments, paramsStr);
        while (YES)
        {
            NSString *string = va_arg(arguments, NSString*);
            if (!string) {
                break;
            }
            [otherTitleList addObject:string];
            NSLog(@"%@",string);
        }
        va_end(arguments);
    }
    return otherTitleList;
}
