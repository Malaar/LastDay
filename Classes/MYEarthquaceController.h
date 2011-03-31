//
//  MYEarthquaceController.h
//  LastDay
//
//  Created by yuriy on 30.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MYEarthquaceAnnotation.h"

typedef enum
{
	parseTitle,
	parseLatitude,
	parseLongitude,
	parseSubject,
	parseOther
} MYParseElement;

@interface MYEarthquaceController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate>
{
	MKMapView* mapViewEarth;
	NSURLConnection* rssConnection;
	NSMutableData* receivedData;	///< received data from server
	NSMutableArray* earthquaces;
	
	MYParseElement parseElement;
	NSMutableString* curElementText;
	MYEarthquaceAnnotation* currEQAnnotation;
	int subjectElementIndex;
}

- (void) loadEarthquaceRSS;

@end
