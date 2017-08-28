//
//  MKMapView+ZoomLevel.h
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/28.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
