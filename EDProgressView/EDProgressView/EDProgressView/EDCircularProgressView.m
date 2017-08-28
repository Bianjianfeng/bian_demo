//
//  EDCircularProgressView.m
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDCircularProgressView.h"


static NSString *const EDCircularProgressViewProgressAnimationKey = @"EDCircularProgressViewProgressAnimationKey";

@interface EDCircularProgressView ()<CAAnimationDelegate>

@property (nonatomic, strong)CAShapeLayer *progressLayer;
@end

@implementation EDCircularProgressView

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
        [self commonInit];
    }
    return self;
}

+ (Class)layerClass {
    return CAShapeLayer.class;
}

- (CAShapeLayer *)shapeLayer {
    return (CAShapeLayer *)self.layer;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = self.tintColor.CGColor;
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.lineCap = kCALineCapButt;
        _progressLayer.lineJoin = kCALineCapButt;
        _progressLayer.strokeEnd = 0;
    }
    return _progressLayer;
}

- (void)commonInit
{
    
    self.shapeLayer.fillColor = UIColor.clearColor.CGColor;
    self.shapeLayer.strokeEnd = 1;
    [self.layer addSublayer:self.progressLayer];
    
    //default
    self.lineWidth = 2;
    self.animationDuration = .3;
    self.progressViewType = EDCircularProgressViewTypeHUD;
    self.progress = 0;
    
    [self tintColorDidChange];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    UIColor *tintColor = self.tintColor;
    self.shapeLayer.strokeColor = tintColor.CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.layer.cornerRadius = self.frame.size.width / 2.0f;
    self.shapeLayer.path = self.bPath.CGPath;
    self.progressLayer.path = self.bPath.CGPath;

}

- (UIBezierPath *)hudPath {
    CGFloat position_y = self.frame.size.height/2;
    CGFloat position_x = self.frame.size.width/2;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_y
                                      startAngle:(-M_PI/2)
                                        endAngle:(3*M_PI/2)
                                       clockwise:YES];
}

- (UIBezierPath *)pulldownPath {
    CGFloat position_y = self.frame.size.height/2;
    CGFloat position_x = self.frame.size.width/2;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_y
                                      startAngle:(M_PI+M_PI_2)
                                        endAngle:-M_PI_2
                                       clockwise:NO];
}

#pragma mark -
#pragma mark --------setter and getter--------

- (void)setProgressViewType:(EDCircularProgressViewType)progressViewType
{
    _progressViewType = progressViewType;
    switch (progressViewType) {
        case EDCircularProgressViewTypeHUD:
        {
            self.bPath = [self hudPath];
        }
            break;
        case EDCircularProgressViewTypePulldownRefresh:
        {
            self.bPath = [self pulldownPath];
        }
            break;
        default:
            break;
    }
}

- (void)setBPath:(UIBezierPath *)bPath
{
    _bPath = bPath;
    [self setNeedsLayout];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (CGFloat)lineWidth {
    return self.shapeLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.shapeLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setProgress:(float)progress {
    NSParameterAssert(progress >= 0 && progress <= 1);
    
    [self stopAnimation];
    
    _progress = progress;
    [self updatePath];
}
- (void)updatePath {
    self.progressLayer.strokeEnd = self.progress;
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    if (animated) {
        if (ABS(self.progress - progress) < CGFLOAT_MIN) {
            return;
        }
        
        [self animateToProgress:progress];
    } else {
        self.progress = progress;
    }
}

- (void)animateToProgress:(float)progress
{
    [self stopAnimation];
    
    // Add shape animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.animationDuration;
    animation.fromValue = @(self.progress);
    animation.toValue = @(progress);
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:animation forKey:EDCircularProgressViewProgressAnimationKey];
    
    _progress = progress;
}

- (void)stopAnimation
{
    [self.progressLayer removeAnimationForKey:EDCircularProgressViewProgressAnimationKey];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

@end
