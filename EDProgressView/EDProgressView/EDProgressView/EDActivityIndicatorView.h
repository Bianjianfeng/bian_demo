//
//  EDActivityIndicatorView.h
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDCircularProgressView.h"

@interface EDActivityIndicatorView : UIView

/**  is animating  */
@property (nonatomic, assign) BOOL animating;

/**  progressType  */
@property (nonatomic, assign) EDCircularProgressViewType progressType;

- (void)setProgress:(float)progress;
- (void)setProgress:(float)progress animated:(BOOL)animated;


- (void)startAnimating;

- (void)stopAnimating;

@end
