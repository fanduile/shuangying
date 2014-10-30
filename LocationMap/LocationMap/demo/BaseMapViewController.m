//
//  BaseMapViewController.m
//  LocationMap
//
//  Created by Chendy on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseMapViewController.h"
#import "CustomAnnotation.h"

@implementation BaseMapViewController
@synthesize map = map_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CLLocationCoordinate2D loc  = CLLocationCoordinate2DMake(32.05000,118.78333);
	CLLocationDegrees lat = loc.latitude;
	CLLocationDegrees lon	= loc.longitude;
	NSLog(@"lat %f",lat);
	NSLog(@"lon %f",lon);
	CLLocationCoordinate2D theCoordinate;
	CLLocationCoordinate2D theCenter;
	NSString* bundlePat = [[NSBundle mainBundle] bundlePath];
    NSLog(@"%@", bundlePat);
    printf("%s",[bundlePat UTF8String]);
	theCoordinate.latitude =lat;
	theCoordinate.longitude=lon;
	[map_ setDelegate: self];
	[map_ setMapType: MKMapTypeStandard];
	
	MKCoordinateRegion theRegin;
	theCenter.latitude =lat; 
	theCenter.longitude = lon;
	theRegin.center=theCenter;
	
	MKCoordinateSpan theSpan;
	theSpan.latitudeDelta = 0.01;
	theSpan.longitudeDelta = 0.01;
	theRegin.span = theSpan;
	[map_ setRegion:theRegin];
	[map_ regionThatFits:theRegin];
	map_.showsUserLocation=YES;
    
    //增加大头针标签
    CustomAnnotation *ann = [[CustomAnnotation alloc] init];
    ann.title = @"增加的大头针";
    NSString* locDesc = [NSString stringWithFormat:@"经度%f  纬度:%f", lat, lon];
    ann.subtitle = locDesc;
    //地点名字
    ann.coordinate = loc;
    [map_ addAnnotation:ann];
    
    //增加长按手势
    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    lpress.minimumPressDuration = 0.5;//按0.5秒作为响应longPress方法
    lpress.allowableMovement = 10.0;
    [map_ addGestureRecognizer:lpress];//m_mapView是MKMapView的实例
}

- (void)showDetails
{
    NSLog(@"showDetails button clicked!");
}

- (void)longPress:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        return;
    }
    //坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:map_];
    CLLocationCoordinate2D touchMapCoordinate =[map_ convertPoint:touchPoint toCoordinateFromView:map_];
    MKPointAnnotation* pointAnnotation = nil;
    pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = touchMapCoordinate;
    pointAnnotation.title = @"通过手势增加的大头针";
    NSString* locDesc = [NSString stringWithFormat:@"经度%f  纬度:%f",touchMapCoordinate.latitude, touchMapCoordinate.longitude];
    pointAnnotation.subtitle = locDesc;
    [map_ addAnnotation:pointAnnotation];
    [pointAnnotation release];
}


- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    if(annotation != map_.userLocation)
    {
        static NSString *defaultPinID = @"com.realtool.pin";
        pinView = (MKPinAnnotationView *)[map_ dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) 
        {
            pinView = [[[MKPinAnnotationView alloc]
                        initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        }
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.image=[UIImage imageNamed:@"locflag1.png"];
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    else 
    {
        [map_.userLocation setTitle:@"我的位置"];
        NSString* locDesc = [NSString stringWithFormat:@"经度%f  纬度:%f", map_.userLocation.coordinate.latitude, map_.userLocation.coordinate.longitude];
        [map_.userLocation setSubtitle:locDesc];
    }
    
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(showDetails) forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = rightButton;
    return pinView;
    
//    MKAnnotationView* newAnnotation=[[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: annotation.title];
//    newAnnotation.canShowCallout=YES;
//    newAnnotation.image=[UIImage imageNamed:@"location.png"];
//    return newAnnotation;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
