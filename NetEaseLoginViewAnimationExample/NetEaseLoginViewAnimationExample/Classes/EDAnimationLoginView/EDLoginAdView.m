//
//  EDLoginAdView.m
//  NetEaseLoginViewAnimationExample
//
//  Created by bianjianfeng on 2017/6/7.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDLoginAdView.h"

@interface EDLoginAdView ()<CAAnimationDelegate>

@property (nonatomic, strong)UIImageView *animateImageView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong)CAAnimationGroup *group;
@end

@implementation EDLoginAdView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame dataSource:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = YES;
    [self addSubview:self.animateImageView];
    
    self.animationDuration = 5.;
    
    [self restartAnimation];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.animateImageView.frame = self.bounds;
}

- (UIImageView *)animateImageView
{
    if (!_animateImageView) {
        _animateImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _animateImageView.backgroundColor = [UIColor whiteColor];
    }
    return _animateImageView;
}

#pragma mark -
#pragma mark --------public methods--------
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self restartAnimation];
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
    _animationDuration = animationDuration;
    [self restartAnimation];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex >= self.dataSource.count) {
        currentIndex = 0;
    }
    _currentIndex = currentIndex;
}

#pragma mark -
#pragma mark --------private methods--------
- (void)restartAnimation
{
    [self stopAnimation];
    self.currentIndex = 0;
    [self startAnimation];
}

- (void)stopAnimation
{
    [self.layer removeAllAnimations];
    [self.animateImageView.layer removeAllAnimations];
}

- (void)dealloc
{
    [self stopAnimation];
}

- (void)startAnimation
{
    if (self.dataSource.count == 0 || self.dataSource.count <=self.currentIndex) {
        return;
    }
    
    self.animateImageView.image = self.dataSource[self.currentIndex];
   
    CABasicAnimation *comeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [comeAnimation setFromValue:[NSNumber numberWithDouble:0]];
    [comeAnimation setToValue:[NSNumber numberWithDouble:1]];
    [comeAnimation setDuration:(self.animationDuration/20.)];
    [comeAnimation setBeginTime:0];

    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAnimation setFromValue:[NSNumber numberWithDouble:1]];
    [scaleAnimation setToValue:[NSNumber numberWithDouble:1.1]];
    [scaleAnimation setDuration:self.animationDuration];
    [scaleAnimation setBeginTime:0];

    CABasicAnimation *hiddenAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [hiddenAnimation setFromValue:[NSNumber numberWithDouble:1]];
    [hiddenAnimation setToValue:[NSNumber numberWithDouble:0]];
    [hiddenAnimation setDuration:(self.animationDuration/4.)];
    [hiddenAnimation setBeginTime:(self.animationDuration*3/4.)];

    self.group = [CAAnimationGroup animation];
    [self.group setDuration:self.animationDuration];
    [self.group setAnimations:[NSArray arrayWithObjects:comeAnimation, scaleAnimation,hiddenAnimation, nil]];
    self.group.delegate = self;
    self.group.removedOnCompletion = NO;
    self.group.fillMode = kCAFillModeForwards;
    self.group.repeatDuration = self.animationDuration;
    self.group.repeatCount = HUGE_VALF;
    [self.animateImageView.layer addAnimation:self.group forKey:@"animationGroup"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[self.animateImageView.layer animationForKey:@"animationGroup"]]) {
        self.currentIndex += 1;
        [self startAnimation];
    }
}


@end
