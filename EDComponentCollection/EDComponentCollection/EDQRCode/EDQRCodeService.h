//
//  EDQRCodeService.h
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EDQRCodeService : NSObject


+ (NSString *)readQRCodeFromImage:(UIImage *)image;

/**
 *  生成二维码
 *
 *  @param source 源
 *  @param size   二维码图片尺寸宽度
 *
 *  @return 图片
 */
+ (UIImage *)filterQRCode:(NSString *)source size:(CGFloat)size;

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
