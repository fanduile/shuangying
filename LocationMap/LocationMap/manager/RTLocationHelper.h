//
//  RTLocationHelper.h
//  RTWeather
//
//  Created by Chen dy on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  管理定位

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


/**
*定位的委托类 
*/
@protocol LocationManagerDelegate <NSObject>
-(void)didGetLocation:(CLLocationCoordinate2D)coordinate;
-(void)didGetLocationFail;
-(void)didFindCity:(NSString *)cityName areaCode:(NSString *)areaCode;//根据城市名找woied
-(void)didFindCityFail;
@end


@interface RTLocationHelper : NSObject<CLLocationManagerDelegate, MKReverseGeocoderDelegate> 
{
    CLLocationManager *_lm;
    
	MKReverseGeocoder *_geo;
    
    id <LocationManagerDelegate> _delegate;
    
    NSString *_latitude;
    
    NSString *_longitude;
    
    NSString *_cityName;
    
    NSString *_areaCode; 
}

@property(assign, nonatomic) id<LocationManagerDelegate> delegate;
@property(nonatomic, copy) NSString *latitude;
@property(nonatomic, copy) NSString *longitude;
@property(nonatomic, copy) NSString *cityName;
@property(nonatomic, copy) NSString *areaCode;

+ (BOOL)isSimulator;
/**获得实例*/
+ (RTLocationHelper*) getInstance;

/**开始定位更新*/
- (void)startUpdate;
/**停止定位更新*/
- (void)stopUpdate;

-(void)getPlaceWithLocation:(CLLocationCoordinate2D)location;

@end
