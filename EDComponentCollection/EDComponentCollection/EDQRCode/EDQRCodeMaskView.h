//
//  EDQRCodeMaskView.h
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanAnimationView.h"

@interface EDQRCodeMaskView : UIView

/**  crop rect  */
@property (nonatomic, assign) CGRect cropRect;

@property (nonatomic, strong) ScanAnimationView *scanView;


@end
