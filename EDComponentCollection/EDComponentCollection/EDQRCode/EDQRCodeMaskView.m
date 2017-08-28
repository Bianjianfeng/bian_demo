
//
//  EDQRCodeMaskView.m
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDQRCodeMaskView.h"
#define KEDQRCodeMaskColor [[UIColor blackColor] colorWithAlphaComponent:0.3]

@interface EDQRCodeMaskView ()
{
    CALayer *top_layer;
    CALayer *left_layer;
    CALayer *bottom_layer;
    CALayer *right_layer;

}

@end

@implementation EDQRCodeMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.cropRect = self.bounds;
        [self initScanAnimationView];
        [self initMaskLayer];
    }
    return self;
}

- (void)initScanAnimationView
{
    ScanAnimationView *animationView = [[ScanAnimationView alloc]initWithFrame:CGRectZero];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.scanImage = [UIImage imageNamed:@"scan"];
    [self addSubview:animationView];
    self.scanView = animationView;
}

- (void)initMaskLayer
{
    // 顶部layer的创建
    top_layer = [[CALayer alloc] init];
    top_layer.backgroundColor = KEDQRCodeMaskColor.CGColor;
    [self.layer addSublayer:top_layer];
    
    // 左侧layer的创建
    left_layer = [[CALayer alloc] init];
    left_layer.backgroundColor = KEDQRCodeMaskColor.CGColor;
    [self.layer addSublayer:left_layer];
    
    // 右侧layer的创建
    right_layer = [[CALayer alloc] init];
    right_layer.backgroundColor = KEDQRCodeMaskColor.CGColor;
    [self.layer addSublayer:right_layer];
    
    // 下面layer的创建
    bottom_layer = [[CALayer alloc] init];
    bottom_layer.backgroundColor = KEDQRCodeMaskColor.CGColor;
    [self.layer addSublayer:bottom_layer];
}

- (void)setCropRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scanView.frame = self.cropRect;
    CGFloat top_layerX = 0;
    CGFloat top_layerY = 0;
    CGFloat top_layerW = self.frame.size.width;
    CGFloat top_layerH = self.cropRect.origin.y;
    top_layer.frame = CGRectMake(top_layerX, top_layerY, top_layerW, top_layerH);

    CGFloat left_layerX = 0;
    CGFloat left_layerY = self.cropRect.origin.y;
    CGFloat left_layerW = self.cropRect.origin.x;
    CGFloat left_layerH = self.cropRect.size.height;
    left_layer.frame = CGRectMake(left_layerX, left_layerY, left_layerW, left_layerH);
    left_layer.backgroundColor = KEDQRCodeMaskColor.CGColor;
    
    CGFloat right_layerX = self.cropRect.origin.x+self.cropRect.size.width;
    CGFloat right_layerY = self.cropRect.origin.y;
    CGFloat right_layerW = self.frame.size.width-right_layerX;
    CGFloat right_layerH = self.cropRect.size.height;
    right_layer.frame = CGRectMake(right_layerX, right_layerY, right_layerW, right_layerH);
    
    CGFloat bottom_layerX = 0;
    CGFloat bottom_layerY = self.cropRect.origin.y+self.cropRect.size.height;
    CGFloat bottom_layerW = self.frame.size.width;
    CGFloat bottom_layerH = self.frame.size.height - bottom_layerY;
    bottom_layer.frame = CGRectMake(bottom_layerX, bottom_layerY, bottom_layerW, bottom_layerH);
}

@end
