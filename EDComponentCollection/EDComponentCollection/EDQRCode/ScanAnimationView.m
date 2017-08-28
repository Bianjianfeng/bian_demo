//
//  ScanAnimationView.m
//  Test
//
//  Created by bianjianfeng on 16/4/18.
//  Copyright © 2016年 bianjianfeng. All rights reserved.
//

#import "ScanAnimationView.h"

@interface ScanAnimationView ()
{
    UIImageView *animateImageView;
    
    UIImageView *topLeft;
    UIImageView *topRight;
    UIImageView *bottomLeft;
    UIImageView *bottomRight;
}


@end

@implementation ScanAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        
        animateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
        animateImageView.backgroundColor = [UIColor clearColor];
        animateImageView.layer.anchorPoint = CGPointMake(0, 0);
        animateImageView.layer.position = CGPointMake(0, 0);
        [self addSubview:animateImageView];
        
        [self setBorderImage];

        _duration = kDefaultAnimateDuration;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    animateImageView.frame =CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    topLeft.frame = CGRectMake(0, 0, 20, 20);
    topRight.frame = CGRectMake(self.frame.size.width-20, 0, 20, 20);
    bottomLeft.frame = CGRectMake(0, self.frame.size.height-20, 20, 20);
    bottomRight.frame = CGRectMake(self.frame.size.width-20, self.frame.size.height-20, 20, 20);
    
    if ([self.layer.animationKeys indexOfObject:@"kDefaultAnimateKey"] != NSNotFound) {
        [self startAnimate];
    }
}

/**
 *  设置边角图片
 *
 *  @since 1.0
 */
- (void)setBorderImage
{
    topLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    topLeft.backgroundColor = [UIColor clearColor];
    topLeft.image = [UIImage imageNamed:@"borderTopLeft_qrcode"];
    [self addSubview:topLeft];
    
    topRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
    topRight.backgroundColor = [UIColor clearColor];
    topRight.image = [UIImage imageNamed:@"borderTopRight_qrcode"];
    [self addSubview:topRight];
    
    bottomLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, 20, 20)];
    bottomLeft.backgroundColor = [UIColor clearColor];
    bottomLeft.image = [UIImage imageNamed:@"borderBottomLeft_qrcode"];
    [self addSubview:bottomLeft];
    
    bottomRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-20, self.frame.size.height-20, 20, 20)];
    bottomRight.backgroundColor = [UIColor clearColor];
    bottomRight.image = [UIImage imageNamed:@"borderBottomRight_qrcode"];
    [self addSubview:bottomRight];
}

- (void)setScanImage:(UIImage *)scanImage
{
    _scanImage = scanImage;
    animateImageView.image = scanImage;
}


/**
 *  开始动画
 *
 *  @since 1.0
 */
- (void)startAnimate
{
    NSLog(@"%@",NSStringFromCGRect(animateImageView.frame));
    if ([animateImageView.layer animationForKey:kDefaultAnimateKey]) {
        [self stopAnimate];
    }
    
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    frameAnimation.fromValue = @(-animateImageView.frame.size.height);
    frameAnimation.toValue = @(animateImageView.frame.size.height/2);
    frameAnimation.removedOnCompletion = YES;
    frameAnimation.repeatCount = MAXFLOAT;
    frameAnimation.duration = _duration;
    
    [animateImageView.layer addAnimation:frameAnimation forKey:kDefaultAnimateKey];

}

/**
 *  停止动画
 *
 *  @since 1.0
 */
- (void)stopAnimate
{
    if ([animateImageView.layer animationForKey:kDefaultAnimateKey]) {
        [animateImageView.layer removeAnimationForKey:kDefaultAnimateKey];
        animateImageView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }
}

@end
