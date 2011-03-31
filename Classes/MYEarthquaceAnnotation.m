//
//  MYEarthquaceAnnotation.m
//  LastDay
//
//  Created by yuriy on 31.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYEarthquaceAnnotation.h"


@implementation MYEarthquaceAnnotation

@synthesize coordinate;
@synthesize magnitude;
@synthesize deep;

//==========================================================================================
+ (id) earthquaceAnnotation
{
	return [[[MYEarthquaceAnnotation alloc] init] autorelease];
}

//==========================================================================================
+ (id) earthquaceAnnotationWithCoordinate: (CLLocationCoordinate2D) aCoord magnitude: (float) aMagnitude
{
	return [[[MYEarthquaceAnnotation alloc] initWithCoordinate:aCoord magnitude:aMagnitude] autorelease];
}

//==========================================================================================
- (id) init
{
	return [self initWithCoordinate:CLLocationCoordinate2DMake(0, 0) magnitude:0];
}

//==========================================================================================
- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoord magnitude: (float) aMagnitude
{
	if(self = [super init])
	{
		[self setCoordinate:aCoord];
		magnitude = aMagnitude;
		deep = 0;
	}
	return self;
}

//==========================================================================================
- (void)setLatitude: (CLLocationDegrees) aLatitude
{
	coordinate.latitude = aLatitude;
}

//==========================================================================================
- (void)setLongitude: (CLLocationDegrees) aLongitude
{
	coordinate.longitude = aLongitude;
}

//==========================================================================================
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
	coordinate = newCoordinate;
}

//==========================================================================================
- (NSString *)title
{
	return [NSString stringWithFormat:@"%0.1f", magnitude];
}

//==========================================================================================
- (NSString *)subtitle
{
	return [NSString stringWithFormat:@"Deep: %0.02f km", deep];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
