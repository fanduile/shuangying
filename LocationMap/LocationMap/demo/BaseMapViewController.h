//
//  BaseMapViewController.h
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface BaseMapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView* map_;
}

@property(nonatomic, retain) IBOutlet MKMapView* map;

- (void)longPress:(UIGestureRecognizer*)gestureRecognizer;
- (void)showDetails;
@end
