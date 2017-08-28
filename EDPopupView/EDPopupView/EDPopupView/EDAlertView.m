//
//  EDAlertView.m
//  EDPopupView
//
//  Created by bianjianfeng on 17/4/17.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDAlertView.h"
#import "MutableParamClass.h"
@interface EDAlertView ()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextView  *messageLabel;
@property (nonatomic, strong) UIView      *buttonView;
@property (nonatomic, strong) UIView      *contentView;

@property (nonatomic, strong) NSMutableArray      *buttons;

@end

@implementation EDAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                  contentView:(UIView *)contentView
                      buttons:(NSArray<EDAlertButtonStyleModel *> *)buttons
{
    self = [super init];
    if (self) {
        //注册键盘出现和消失/通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pxKeyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pxKeyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        EDAlertViewConfig *config = [EDAlertViewConfig sharedConfig];
        
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,config.marginHeight,config.contentWidth, 40)];
        [self addSubview:self.titleLabel];
        self.titleLabel.textColor = config.titleColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:config.titleFontSize];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = title;
        CGFloat lastBottomY = self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height;
        
        // Optional Content View
        if (contentView) {
            _contentView = contentView;
            _contentView.frame = CGRectMake(0, lastBottomY,_contentView.frame.size.width, _contentView.frame.size.height);
            _contentView.center = CGPointMake(config.contentWidth/2, _contentView.center.y);
            [self addSubview:_contentView];
            lastBottomY += contentView.frame.size.height + config.marginHeight;
        }
        if (message) {
            self.messageLabel = [[UITextView alloc]initWithFrame:CGRectMake(config.marginHeight,lastBottomY,config.contentWidth - config.marginHeight*2,44)];
            [self addSubview:self.messageLabel];
            self.messageLabel.textColor = config.messageTextColor;
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = [UIFont systemFontOfSize:config.messageFontSize];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.text = message;
            self.messageLabel.frame = [self adjustLabelFrameHeight:self.messageLabel config:config buttonsCount:buttons.count];
            
            self.messageLabel.editable = NO;
            if (self.messageLabel.contentSize.height > self.messageLabel.frame.size.height) {
                self.messageLabel.scrollEnabled = YES;
            }
            lastBottomY = self.messageLabel.frame.origin.y+self.messageLabel.frame.size.height;
        }
        
        
        CGFloat buttonsViewHeight = (buttons.count > 2)?(buttons.count*(config.buttonHeight+config.marginHeight)):config.buttonHeight;
        if (buttons.count == 0) {
            buttonsViewHeight = 0;
        }
        self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, lastBottomY+config.marginHeight, config.contentWidth, buttonsViewHeight)];
        [self addSubview:self.buttonView];

        if (buttons.count > 2) {
            for (int i = buttons.count-1;i >= 0;i--) {
                EDAlertButtonStyleModel *styleModel = buttons[i];
                EDAlertButton *alertButton = [EDAlertButton buttonWithStyleModel:styleModel target:self selector:@selector(dismiss:)];
                [alertButton addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
                [alertButton addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
                
                alertButton.frame = CGRectMake(config.marginHeight, (config.buttonHeight+config.marginHeight)*(buttons.count-1-i), config.contentWidth-2*config.marginHeight, config.buttonHeight);
                [self.buttonView  addSubview:alertButton];
                [self.buttons addObject:alertButton];
            }
        }else {
            for (int i = 0;i < buttons.count;i++) {
                EDAlertButtonStyleModel *styleModel = buttons[i];
                EDAlertButton *alertButton = [EDAlertButton buttonWithStyleModel:styleModel target:self selector:@selector(dismiss:)];
                [alertButton addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
                [alertButton addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
                
                alertButton.frame = CGRectMake(config.contentWidth/2*i, 0, config.contentWidth/2, config.buttonHeight);
                if (buttons.count == 1) {
                    alertButton.frame = CGRectMake(0, 0, config.contentWidth, config.buttonHeight);
                }else {
                    // Line
                    CALayer *lineLayer = [CALayer layer];
                    lineLayer.backgroundColor = [[UIColor colorWithWhite:0.60 alpha:0.4] CGColor];
                    lineLayer.frame = CGRectMake(config.contentWidth/2, 0, 0.5, config.buttonHeight);
                    [self.buttonView.layer addSublayer:lineLayer];
                }
                [self.buttonView  addSubview:alertButton];
                [self.buttons addObject:alertButton];
            }
        }
        
        // Line
        CALayer *lineLayer = [CALayer layer];
        lineLayer.backgroundColor = [[UIColor colorWithWhite:0.60 alpha:0.4] CGColor];
        lineLayer.frame = CGRectMake(0, 0, self.buttonView.frame.size.width, 0.5);
        [self.buttonView.layer addSublayer:lineLayer];

        
        lastBottomY = self.buttonView.frame.origin.y+self.buttonView.frame.size.height;
        
        self.frame = CGRectMake(0, 0, config.contentWidth, lastBottomY);

        
    }
    return self;
}

//键盘弹出、落下时候窗口移动
- (void)pxKeyboardWasShown:(NSNotification *) notif {
    [UIView animateWithDuration:0.2 animations:^{
        self.center = CGPointMake(CGRectGetMidX(self.attachedView.bounds), CGRectGetMidY(self.attachedView.bounds)-100);
    }];
}

- (void)pxKeyboardWasHidden:(NSNotification *) notif {
    [UIView animateWithDuration:0.2 animations:^{
        self.center = CGPointMake(CGRectGetMidX(self.attachedView.bounds), CGRectGetMidY(self.attachedView.bounds));
    }];
}

- (void)dismiss:(id)sender
{
    [self hide];
    if (self.hiddenCompletionBlock) {
        NSInteger buttonIndex = NSNotFound;
        if (self.buttons) {
            NSUInteger index = [self.buttons indexOfObject:sender];
            if (index != NSNotFound) {
                buttonIndex = index;
            }
        }
        self.hiddenCompletionBlock(self,buttonIndex);
    }
}


- (void)setBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.6]];
}

- (void)clearBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
}

- (CGRect)adjustLabelFrameHeight:(UITextView *)label
                          config:(EDAlertViewConfig *)config
                    buttonsCount:(NSInteger)count
{
    CGFloat height;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [label.text sizeWithFont:label.font
                             constrainedToSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        height = size.height;
#pragma clang diagnostic pop
    } else {
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        context.minimumScaleFactor = 1.0;
        CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:label.font}
                                                 context:context];
        height = bounds.size.height;
    }
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat buttonsViewHeight = (count > 2)?(count*(config.buttonHeight+config.marginHeight)):config.buttonHeight;
    if (count == 0) {
        buttonsViewHeight = 0;
    }
    height = MIN(height, screenHeight-label.frame.origin.y- buttonsViewHeight-config.marginHeight-20);
    return CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height);
}


+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          contentView:(UIView *)contentView
      completionBlock:(EDPopupCompletionBlock)block
       otherTitleList:(NSArray *)otherTitleList
{
    NSMutableArray *buttonModels = [NSMutableArray array];
    
    EDAlertButtonStyle style = (otherTitleList.count <= 1)?EDAlertButtonStyleHorizontalTwoButtons:EDAlertButtonStyleVerticalMoreButtons;
    
    if (cancelTitle){
        EDAlertButtonStyleModel *cancelModel = [EDAlertButtonStyleModel cancelButtonStyleWithButtonStyle:style];
        cancelModel.title = cancelTitle;
        [buttonModels addObject:cancelModel];
    }
    
    for (NSString *title in otherTitleList){
        EDAlertButtonStyleModel *model = [EDAlertButtonStyleModel createStyleModelWithButtonStyle:style];
        model.title = title;
        [buttonModels addObject:model];
    }
    
    
    //cancelTitle 和otherTitles都为空时添加一个cancel按钮
    if (buttonModels.count == 0){
        EDAlertButtonStyleModel *cancelModel = [EDAlertButtonStyleModel cancelButtonStyleWithButtonStyle:EDAlertButtonStyleHorizontalTwoButtons];
        cancelModel.titleColor = [UIColor orangeColor];
        cancelModel.title = @"确定";
        [buttonModels addObject:cancelModel];
    }else if (buttonModels.count == 1){
        EDAlertButtonStyleModel *cancelModel = [buttonModels firstObject];
        cancelModel.operationStyle = EDAlertOperationButtonStyleCancel;
        cancelModel.titleColor = [UIColor orangeColor];
    }
    
    
    EDAlertView *alertView = [[EDAlertView alloc]initWithTitle:title message:message contentView:contentView buttons:buttonModels];
    alertView.hiddenCompletionBlock = block;
    
    [alertView show];

}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          contentView:(UIView *)contentView
      completionBlock:(EDPopupCompletionBlock)block
          otherTitles:(NSString *)otherTitles,...NS_REQUIRES_NIL_TERMINATION
{
    va_list arguments;
    
    NSMutableArray *otherTitleList = [NSMutableArray new];
    if (otherTitles) {
        [otherTitleList addObject:otherTitles];
        va_start(arguments, otherTitles);
        while (YES)
        {
            NSString *string = va_arg(arguments, NSString*);
            if (!string) {
                break;
            }
            [otherTitleList addObject:string];
            NSLog(@"%@",string);
        }
        va_end(arguments);
    }
    [EDAlertView showWithTitle:title message:message cancelTitle:cancelTitle contentView:contentView completionBlock:block otherTitleList:otherTitleList];
}

@end


@implementation EDAlertViewConfig

+ (EDAlertViewConfig *)sharedConfig
{
    static EDAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        config = [EDAlertViewConfig new];
    });
    
    return config;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupDefaultConfig];
    }
    return self;
}

- (void)setupDefaultConfig
{
    self.buttonHeight   = 44.0f;
    self.marginHeight   = 9.0f;
    
    self.titleFontSize   = 17.0f;
    self.messageFontSize = 15.0f;
    
    self.titleColor         = ED_UIColorFromRGB(0x000000);
    self.messageTextColor   = ED_UIColorFromRGB(0x000000);
}

@end
