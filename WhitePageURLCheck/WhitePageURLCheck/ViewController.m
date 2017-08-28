//
//  ViewController.m
//  WhitePageURLCheck
//
//  Created by bianjianfeng on 2017/8/3.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self validateUrl:[NSURL URLWithString:@"http://h5.senqiang.cn/Valuation"]];
}

-(void) validateUrl: (NSURL *) candidate {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:candidate];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (error) {
            NSLog(@"不可用");
        }else{
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self checkHttpRequestHaveBodyContent:dataString];
            NSLog(@"可用");
        }
    }];
    [task resume];
}


- (void)checkHttpRequestHaveBodyContent:(NSString *)htmlString
{
    NSRange range1 = [htmlString rangeOfString:@"<body>"];
    NSRange range2 = [htmlString rangeOfString:@"</body>"];
    if(range1.location !=NSNotFound && range1.length!=0)
    {
        NSString* bodyString= [htmlString substringWithRange:NSMakeRange(range1.location, range2.location-range1.location+range2.length)];
        NSLog(@"%@",bodyString);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
