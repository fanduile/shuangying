//
//  GMapCtrl.h
//  xmap
//
//  Created by Chen dy on 3/9/11.
//  Copyright 2011 fhcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GMapCtrl : UIView<MKMapViewDelegate>
{
	MKMapView* _mapView;
	NSArray* _points;
	UIColor* _lineColor;
	bool isLine;
}



@property (nonatomic, retain) NSArray* points;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UIColor* lineColor; 
@property (nonatomic) bool isLine;

-(id) initWithRoute:(NSArray*)routePoints mapView:(MKMapView*)mapV;
-(void)changeMapType:(id)sender event:(id)event;
@end
