//
//  EDLoginAdView.h
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDLoginAdView : UIView


/**  动画图片数据源  */
@property (nonatomic, strong) NSArray *dataSource;

/**  动画间隔  */
@property (nonatomic, assign) CGFloat animationDuration;

- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource;


@end
