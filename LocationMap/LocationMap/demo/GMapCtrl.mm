//
//  GMapCtrl.mm
//  xmap
//
//  Created by Chen dy on 3/9/11.
//  Copyright 2011 fhcom. All rights reserved.
//

#import "GMapCtrl.h"
#import "CustomAnnotation.h"

@implementation GMapCtrl
@synthesize mapView   = _mapView;
@synthesize points    = _points;
@synthesize lineColor = _lineColor; 
@synthesize isLine;

/**********************************************************************
 **函数功能:初始化地图控件
 **输入参数：routePoints, mapV
 **类型:NSArray*, MKMapView*
 **输出参数:无
 **返回：返回地图控件的引用
 **********************************************************************/
-(id) initWithRoute:(NSArray*)routePoints mapView:(MKMapView*)mapView
{
	self = [super initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
	[self setBackgroundColor:[UIColor clearColor]];	
	[self setMapView:mapView];
	[self setPoints:routePoints];
	
	// determine the extents of the trip points that were passed in, and zoom in to that area. 

	MKCoordinateRegion region;
	if(self.points.count <= 1)
	{
		CLLocation* currentLocation = [self.points objectAtIndex:0];
		CLLocationCoordinate2D coordinate;
		coordinate = currentLocation.coordinate;
		MKCoordinateSpan theSpan;
		//地图的范围 越小越精确
		theSpan.latitudeDelta=0.03;
		theSpan.longitudeDelta=0.03;
		region.center= coordinate;
		region.span=theSpan;
		
	}
	else 
	{
		CLLocationDegrees maxLat = -90;
		CLLocationDegrees maxLon = -180;
		CLLocationDegrees minLat = 90;
		CLLocationDegrees minLon = 180;
		
		for(int idx = 0; idx < self.points.count; idx++)
		{
			CLLocation* currentLocation = [self.points objectAtIndex:idx];
			if(currentLocation.coordinate.latitude > maxLat)
				maxLat = currentLocation.coordinate.latitude;
			if(currentLocation.coordinate.latitude < minLat)
				minLat = currentLocation.coordinate.latitude;
			if(currentLocation.coordinate.longitude > maxLon)
				maxLon = currentLocation.coordinate.longitude;
			if(currentLocation.coordinate.longitude < minLon)
				minLon = currentLocation.coordinate.longitude;	
		}			
		region.center.latitude     = (maxLat + minLat) / 2;
		region.center.longitude    = (maxLon + minLon) / 2;
		double latiDeta = maxLat - minLat;
		double longiDeta = maxLon - minLon;
		if(latiDeta < 0.01)
		{
			latiDeta = 0.01;
		}
		if(longiDeta < 0.01)
		{
			longiDeta = 0.01;
		}
		region.span.latitudeDelta  = latiDeta;
		region.span.longitudeDelta = longiDeta;		
	}
	[self.mapView setRegion:region];
	[self.mapView setDelegate:self];	
	[self setNeedsDisplay];
	return self;
}

/**********************************************************************
 **函数功能:改变地图类型
 **输入参数：(发送者)sender, (事件)event
 **类型:id, id
 **输出参数:无
 **返回：无
 **********************************************************************/
-(void)changeMapType:(id)sender event:(id)event
{
	UIControl* control = (UIControl*)sender;
	if([control isKindOfClass:[UISegmentedControl class]])
	{
		UISegmentedControl* segment = (UISegmentedControl*)control;
		int selectedIndex = segment.selectedSegmentIndex;
		if(selectedIndex == 0)
		{
			_mapView.mapType = MKMapTypeStandard;
		}
		else if(selectedIndex == 1)
		{
			_mapView.mapType = MKMapTypeSatellite;
		}
		else 
		{
			_mapView.mapType = MKMapTypeHybrid;
		}		
	}
}


/**********************************************************************
 **函数功能:在地图上增加标注
 **输入参数：mapView, annotation
 **类型:MKMapView*, id <MKAnnotation>
 **输出参数:无
 **返回：标注图标
 **********************************************************************/
//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
//{  
//    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];  
//    newAnnotation.pinColor = MKPinAnnotationColorRed;  
//    newAnnotation.animatesDrop = YES;   
//    newAnnotation.canShowCallout=YES;       
//    return newAnnotation;  
//}



/**********************************************************************
 **函数功能:绘图，主要是在地图上进行连线的绘制
 **输入参数：绘图区域rect
 **类型:CGRect
 **输出参数:无
 **返回：无
 **********************************************************************/
- (void)drawRect:(CGRect)rect
{
	if(!isLine)
	{
		return;
	}
	if(!self.hidden && nil != self.points && self.points.count > 0)
	{
		CGContextRef context = UIGraphicsGetCurrentContext(); 
		if(nil == self.lineColor)
			self.lineColor = [UIColor orangeColor];
		
		CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
		CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
		
		// Draw them with a 2.0 stroke width so they are a bit more visible.
		CGContextSetLineWidth(context, 2.0);
		
		
		for(int idx = 0; idx < self.points.count; idx++)
		{
			CLLocation* location = [self.points objectAtIndex:idx];
			CGPoint point = [_mapView convertCoordinate:location.coordinate toPointToView:self];
			
			if(idx == 0)
			{
				// move to the first point
				CGContextMoveToPoint(context, point.x, point.y);
			}
			else
			{
				CGContextAddLineToPoint(context, point.x, point.y);
			}
		}		
		CGContextStrokePath(context);
	}
}

/**事件检测*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	return nil;
}

#pragma mark mapView delegate functions
/**地图放大缩小开始的委托回调*/
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	self.hidden = YES;
}

/**地图放大缩小结束的委托回调*/
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	self.hidden = NO;
	[self setNeedsDisplay];
}

-(void) dealloc
{
	[_points release];
	[super dealloc];
}


@end
