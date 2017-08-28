//
//  CustomViewController.m
//  CustomTabbarController
//
//  Created by bianjianfeng on 2017/4/25.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "CustomViewController.h"
#import "ViewController.h"
@interface CustomViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger offsetIndex;


@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    ViewController *viewC1 = [[ViewController alloc]init];
    viewC1.view.backgroundColor = [UIColor redColor];
    
    ViewController *viewC2 = [[ViewController alloc]init];
    viewC2.view.backgroundColor = [UIColor blueColor];
    
    ViewController *viewC3 = [[ViewController alloc]init];
    viewC3.view.backgroundColor = [UIColor yellowColor];
    
    ViewController *viewC4 = [[ViewController alloc]init];
    viewC4.view.backgroundColor = [UIColor orangeColor];
    
    _viewControllers = @[viewC1,viewC2,viewC3,viewC4];
    
    [self setControllers];
    
}

- (void)setControllers
{
    self.scrollView.contentSize = CGSizeMake(_viewControllers.count *self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *viewController = _viewControllers[i];
        viewController.view.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:viewController.view];
    }
}

/*!
 * @brief 手释放后pager归位后的处理
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (int)scrollView.contentOffset.x/scrollView.frame.size.width;
    self.currentIndex = index;

    [self viewDidStatusUpdate];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat currentIndexOffsetX = self.currentIndex*self.scrollView.frame.size.width;
//    NSLog(@"%.2f  ---- %.2f",contentOffsetX,currentIndexOffsetX);
    
    
    if (contentOffsetX < currentIndexOffsetX) {
        if (self.currentIndex == 0) {
            return;
        }
        self.offsetIndex = self.currentIndex - 1;
        [self viewWillStatusUpdate];
    }else if(contentOffsetX > currentIndexOffsetX) {
        if (self.currentIndex == self.viewControllers.count-1) {
            return;
        }
        
        self.offsetIndex = self.currentIndex + 1;
        [self viewWillStatusUpdate];
    }
}


- (void)viewWillStatusUpdate
{
    UIViewController *viewController = _viewControllers[self.currentIndex];
    [viewController viewWillDisappear:YES];
    if (self.offsetIndex != NSNotFound) {
        UIViewController *viewController = _viewControllers[self.currentIndex];
        [viewController viewWillAppear:YES];
    }
}

- (void)viewDidStatusUpdate
{
    UIViewController *viewController = _viewControllers[self.currentIndex];
    [viewController viewDidAppear:YES];
    if (self.offsetIndex != NSNotFound) {
        UIViewController *viewController = _viewControllers[self.currentIndex];
        [viewController viewDidDisappear:YES];
    }
}

- (BOOL)rangeOfIndex:(NSInteger)index
{
    return (index > 0 && self.viewControllers.count > index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
