//
//  ViewController.m
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "ViewController.h"
#import "EDQRCodeReaderView.h"
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "EDLocationService.h"

@interface ViewController ()<EDQRReaderViewResultDelegate,MKMapViewDelegate>

@property (nonatomic, strong) EDQRCodeReaderView *readerView;

@property (nonatomic, strong) UIButton *scanBtn;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.mapView];

    [self.view addSubview:self.readerView];
    
    [self.view addSubview:self.scanBtn];
    
    [self.readerView startScan];
    self.scanBtn.selected = YES;
    
    
//    [EDLocationService startLocationService:^(CLLocation *userLocation) {
//        [self updateMapViewRegion:userLocation];
//    } errorBlock:nil stopBlock:nil];
}

- (void)updateMapViewRegion:(CLLocation *)location
{
    CLLocationCoordinate2D centerCoord = location.coordinate;
    [self.mapView setCenterCoordinate:centerCoord zoomLevel:14 animated:NO];
//    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoord, <#MKCoordinateSpan span#>)
//    [self.mapView setRegion:<#(MKCoordinateRegion)#>:centerCoord];
}

- (void)scanAction:(UIButton *)sender
{
    self.scanBtn.selected = !self.scanBtn.selected;
    if (self.scanBtn.selected) {
        [self.readerView startScan];
    }else {
        [self.readerView stopScan];
    }
}


- (MKMapView *)mapView
{
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _mapView.delegate = self;
        _mapView.mapType = MKMapTypeStandard;
    
        _mapView.showsUserLocation= YES;
    }
    return _mapView;
}

- (UIButton *)scanBtn
{
    if (_scanBtn == nil) {
        _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanBtn.frame = CGRectMake(100, 400, 200, 50);
        [_scanBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_scanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_scanBtn setTitle:@"扫码" forState:UIControlStateNormal];
        [_scanBtn setTitle:@"停止" forState:UIControlStateSelected];
        [_scanBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _scanBtn;
}

- (EDQRCodeReaderView *)readerView
{
    if (_readerView == nil) {
        _readerView = [[EDQRCodeReaderView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
        _readerView.scanRect = CGRectMake((_readerView.frame.size.width-200)/2, (_readerView.frame.size.height-200)/2, 200, 200);
        _readerView.delegate = self;
    }
    return _readerView;
}

#pragma mark -
#pragma mark --------EDQRReaderViewResultDelegate--------
- (void)qrReaderView:(EDQRCodeReaderView *)readerView didReadQRCodeResult:(NSString *)result
{
    NSLog(@"%@",result);
}


#pragma mark -
#pragma mark --------MKMapViewDelegate--------
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D reverPoint = mapView.region.center;
    
    NSLog(@"%.6f   ======    %.6f",reverPoint.latitude,reverPoint.longitude);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
    [self.mapView setCenterCoordinate:loc zoomLevel:14 animated:NO];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapView setRegion:region animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
