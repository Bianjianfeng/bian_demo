//
//  EDActivityIndicatorView.m
//  EDProgressView
//
//  Created by bianjianfeng on 2017/5/26.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDActivityIndicatorView.h"
#import "EDCircularProgressView.h"

static NSString *const EDActivityIndicatorViewAnimationKey = @"EDActivityIndicatorViewAnimationKey";

@interface EDActivityIndicatorView ()

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) EDCircularProgressView *circularView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong, readwrite) NSTimer *pulldownAnimateTimer;

@end

@implementation EDActivityIndicatorView

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
        [self initSubViews];
    }
    return self;
}

- (EDCircularProgressView *)circularView
{
    if (!_circularView) {
        _circularView = [[EDCircularProgressView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _circularView.lineWidth = 2;
        _circularView.progressColor = kUIColorFromRGB(0xFA6E00);
        _circularView.tintColor = kUIColorFromRGB(0xe6e6e6);
        _circularView.animationDuration = 0.3;
        [_circularView setProgress:0.2];
    }
    return _circularView;
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"centerImage_loading"]];
        _centerImageView.frame = CGRectMake(0, 0, 28, 21);
    }
    return _centerImageView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.clipsToBounds = YES;
        _backgroundView.layer.cornerRadius = 15;
    }
    return _backgroundView;
}

- (void)initSubViews
{
    [self addSubview:self.backgroundView];
    [self addSubview:self.circularView];
    [self addSubview:self.centerImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    self.circularView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.centerImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}


#pragma mark -
#pragma mark --------enter background notification--------
- (void)registerForNotificationCenter {
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)removeNotificationCenter {
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center removeObserver:self];
}

- (void)applicationDidEnterBackground:(NSNotification *)note {
    [self removeAnimation];
}

- (void)applicationWillEnterForeground:(NSNotification *)note {
    if (self.animating) {
        [self addAnimation];
    }
}

#pragma mark -
#pragma mark --------public methods--------
- (void)startAnimating {
    if (_animating) {
        return;
    }
    
    _animating = YES;
    
    [self registerForNotificationCenter];
    
    [self addAnimation];
}

- (void)stopAnimating {
    if (!_animating) {
        return;
    }
    
    _animating = NO;
    
    [self removeNotificationCenter];
    
    [self removeAnimation];
}

- (void)setProgressType:(EDCircularProgressViewType)progressType
{
    _progressType = progressType;
    self.circularView.progressViewType = progressType;
    switch (progressType) {
        case EDCircularProgressViewTypeHUD:
        {
            self.circularView.progress = 0.2;
            self.circularView.animationDuration = 0.3;
        }
            break;
        case EDCircularProgressViewTypePulldownRefresh:
        {
            self.circularView.progress = 0;
            self.circularView.animationDuration = 0.9;
        }
            break;
        default:
            break;
    }
}

#pragma mark - Add and remove animation

- (void)addAnimation {
    switch (self.progressType) {
        case EDCircularProgressViewTypeHUD:
        {
            [self addHudLoadingAniamtion];
        }
            break;
        case EDCircularProgressViewTypePulldownRefresh:
        {
            [self addPulldownLoadingAniamtion];
        }
            break;
        default:
            break;
    }
}

- (void)addHudLoadingAniamtion
{
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.toValue        = @(1*2*M_PI);
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinAnimation.duration       = 0.8;
    spinAnimation.repeatCount    = INFINITY;
    [self.circularView.layer addAnimation:spinAnimation forKey:EDActivityIndicatorViewAnimationKey];
}

- (void)addPulldownLoadingAniamtion
{
    [self onPulldownAnimateTimer:nil];
    self.pulldownAnimateTimer = [NSTimer scheduledTimerWithTimeInterval:(self.circularView.animationDuration+0.1)
                                                                  target:self
                                                                selector:@selector(onPulldownAnimateTimer:)
                                                                userInfo:nil
                                                                 repeats:YES];
}

- (void)onPulldownAnimateTimer:(NSTimer *)timer
{
    self.circularView.progress = 0;
    [self.circularView setProgress:1 animated:YES];
}

- (void)removeAnimation {
    switch (self.progressType) {
        case EDCircularProgressViewTypeHUD:
        {
            [self.circularView.layer removeAnimationForKey:EDActivityIndicatorViewAnimationKey];
        }
            break;
        case EDCircularProgressViewTypePulldownRefresh:
        {
            if (self.pulldownAnimateTimer) {
                [self.pulldownAnimateTimer invalidate];
                self.pulldownAnimateTimer = nil;
            }
            [self.circularView.layer removeAllAnimations];
        }
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma mark --------set progress--------
- (void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    [self.circularView setProgress:progress animated:animated];
}

@end
