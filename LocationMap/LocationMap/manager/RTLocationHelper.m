//
//  RTLocationHelper.m
//  RTWeather
//
//  Created by Chen dy on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RTLocationHelper.h"

@interface RTLocationHelper (Private)
-(void)getPlaceWithLocation:(CLLocationCoordinate2D)location;
@end



@implementation RTLocationHelper

@synthesize latitude = _latitude, longitude = _longitude, 
cityName = _cityName, areaCode = _areaCode,delegate = _delegate;

//Manager 实例
static RTLocationHelper * _instance = nil; 

// 获取实例
+ (RTLocationHelper *) getInstance
{
	if (nil == _instance) 
	{
		_instance = [[RTLocationHelper alloc] init];
	}
	return _instance;
}

// 初始化定位设备
-(id)init
{
	if((self = [super init]))
	{
		if (_lm != nil) 
		{
			return self;
		}
		_lm = [[CLLocationManager alloc] init];
		_lm.desiredAccuracy = kCLLocationAccuracyBest;
		_lm.distanceFilter = 0.5;
        _lm.delegate = self;        
	}
	return self;
}

+ (BOOL)isSimulator 
{
	NSString *model = [[UIDevice currentDevice] model];
	if (NSNotFound != [model rangeOfString:@"Simulator"].location) 
    {
		return YES;
	}
	return NO;
}

// 开始更新定位信息
-(void)startUpdate
{
	if(_lm != nil)
	{
        NSLog(@"start update location...");
        if([RTLocationHelper isSimulator])
        {
            float latitude = 39.8143218; 
            float longitude = 116.327154;
            CLLocation *powellsTech = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
            [self locationManager:_lm didUpdateToLocation:powellsTech
                     fromLocation:powellsTech];
        }
        else
        {
            [_lm startUpdatingLocation];
        }
	}
}


// 停止定位
-(void)stopUpdate
{
	if(_lm != nil)
	{
        NSLog(@"stop update location...");
		[_lm stopUpdatingLocation];
	}
}



// 定位成功，获取定位到的经纬度
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
	[self setLatitude:[NSString stringWithFormat:@"%f", coordinate.latitude]];
    [self setLongitude:[NSString stringWithFormat:@"%f", coordinate.longitude]];
	
    NSLog(@"location has got -------> latitude: %@ , longitude: %@", self.latitude, self.longitude);
	
    if ([_delegate respondsToSelector:@selector(didGetLocation:)])
    {
        [_delegate didGetLocation:coordinate];
    }
    NSString* message = [NSString stringWithFormat:@"经度:%f,纬度:%f",coordinate.longitude, coordinate.latitude];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"定位成功" 
                                                    message:message 
                                                   delegate:nil
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
}


// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"update location error! %@", [error description]);
    // TODO: 失败提示
    [self stopUpdate];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败"
                                                    message:@"请开启“设置->通用->定位服务“中的相关选项。"
                                                   delegate:self 
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([_delegate respondsToSelector:@selector(didGetLocationFail)])
    {
        [_delegate didGetLocationFail];
    }
}

-(void)getPlaceWithLocation:(CLLocationCoordinate2D)location
{
	NSLog(@"start find place information...");
    _geo = [[MKReverseGeocoder alloc]initWithCoordinate:location];
	_geo.delegate = self;
	[_geo start];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)pk
{
	NSLog(@"has find place: %@", pk.locality);
    
    NSArray *cnames = [NSArray arrayWithObjects: @"南京市", @"镇江市", @"常州市", @"无锡市", @"苏州市", @"徐州市", @"连云港市", @"淮安市", @"宿迁市", @"盐城市", @"扬州市", @"泰州市", @"南通市", nil];
    NSArray *enames = [NSArray arrayWithObjects: @"nanjing", @"zhenjiang", @"changzhou", @"wuxi", @"suzhou", @"xuzhou", @"lianyuguang", @"huaian", @"suqian", @"yancheng", @"yangzhou", @"taizhou", @"nantong", nil];
    
    NSString *locality = pk.locality;
    NSInteger findIndex = NSNotFound;
    if ((findIndex = [cnames indexOfObject:locality]) == NSNotFound) 
	{
        findIndex = [enames indexOfObject:[locality lowercaseString]];
    }
    if (findIndex == NSNotFound) 
	{
        if ([self.delegate respondsToSelector:@selector(didFindCityFail)])
        {
            [_delegate didFindCityFail];
        }
    } 
	else
	{

        
        if ([self.delegate respondsToSelector:@selector(didFindCity:woeid:)])
        {
            [_delegate didFindCity:_cityName areaCode:_areaCode];
        }
    }    
    [_geo cancel];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
	NSLog(@"find place error! %@", [error description]);
    if ([self.delegate respondsToSelector:@selector(didFindCityFail)])
    {
        [_delegate didFindCityFail];
    }
	[_geo cancel];
}


- (void)dealloc 
{
    [_areaCode release];
	[_lm release];
    [_geo release];    
	[super dealloc];
}



@end
