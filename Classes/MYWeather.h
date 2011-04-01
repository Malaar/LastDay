//
//  MYWeatherAnnotation.h
//  LastDay
//
//  Created by Malaar on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MYWeather : NSObject 
{
	CLLocationCoordinate2D coordinate;		///< geo coordinate
	NSString* strLocation;					///< describe location
	float elevation;						///< elevation above sea surface
	UIImage* weatherImage;					///< 
	float temperature;						///< 
	float humidity;							///< 
	
	NSString* windDir;						///< 
	float windDegrees;						///< 
	float windSpeed;						///< speed of wind (in mph) 
	
	float pressureMB;
	float pressureIn;

}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString* strLocation;
@property (nonatomic, assign) float elevation;
@property (nonatomic, retain) UIImage* weatherImage;
@property (nonatomic, assign) float temperature;
@property (nonatomic, assign) float humidity;

@property (nonatomic, retain) NSString* windDir;
@property (nonatomic, assign) float windDegrees;
@property (nonatomic, assign) float windSpeed;

@property (nonatomic, assign) float pressureMB;
@property (nonatomic, assign) float pressureIn;

+ (id) weather;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
