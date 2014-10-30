//
//  DrawMapViewController.h
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GMapCtrl.h"

@interface DrawMapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView* map_;
    NSMutableArray* points_;
    GMapCtrl* routeView_;
}

@property(nonatomic, retain) IBOutlet MKMapView* map;
@property(nonatomic, retain) NSMutableArray* points;
@property(nonatomic, retain) GMapCtrl* routeView;

-(IBAction)clickDrawLine:(id)sender;
- (void)longPress:(UIGestureRecognizer*)gestureRecognizer;
- (void)showDetails;
@end
