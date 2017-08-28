//
//  EDQRCodeReaderView.h
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class EDQRCodeReaderView;
@protocol EDQRReaderViewResultDelegate <NSObject>

@optional
- (void)qrReaderView:(EDQRCodeReaderView *)readerView didReadQRCodeResult:(NSString *)result;

@end


@interface EDQRCodeReaderView : UIView

/**  torch mode(闪光灯开关)  */
@property (nonatomic, assign) AVCaptureTorchMode torchMode;

/**  scan rect  */
@property (nonatomic, assign) CGRect scanRect;

/**  delegate  */
@property (nonatomic, assign) id<EDQRReaderViewResultDelegate> delegate;

- (void)startScan;

- (void)stopScan;


@end
