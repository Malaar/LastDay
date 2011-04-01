//
//  MYEarthquaceAnnotation.h
//  LastDay
//
//  Created by yuriy on 31.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MYEarthquaceAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;		///< geo coordinate

	float magnitude;						///< magnitude of earthquace
	float deep;								///< deep of earthquace
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) float magnitude;
@property (nonatomic, assign) float deep;

+ (id) earthquaceAnnotation;
+ (id) earthquaceAnnotationWithCoordinate: (CLLocationCoordinate2D) aCoord magnitude: (float) aMagnitude;
- (id) init;
- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoord magnitude: (float) aMagnitude;

- (void)setLatitude: (CLLocationDegrees) aLatitude;
- (void)setLongitude: (CLLocationDegrees) aLongitude;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

- (NSString *)title;
- (NSString *)subtitle;

@end
