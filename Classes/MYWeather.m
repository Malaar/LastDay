//
//  MYWeatherAnnotation.m
//  LastDay
//
//  Created by Malaar on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYWeather.h"


@implementation MYWeather

@synthesize coordinate;
@synthesize strLocation;
@synthesize elevation;
@synthesize weatherImage;
@synthesize temperature;
@synthesize humidity;
@synthesize windDir;
@synthesize windDegrees;
@synthesize windSpeed;
@synthesize pressureMB;
@synthesize pressureIn;

//==========================================================================================
+ (id) weather
{
	return [[[MYWeather alloc] init] autorelease];
}

//==========================================================================================
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
	self.coordinate = newCoordinate;
}


@end
