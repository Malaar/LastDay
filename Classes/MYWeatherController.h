//
//  MYWeatherController.h
//  LastDay
//
//  Created by yuriy on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MYWeatherController : UIViewController 
			<MKMapViewDelegate, NSXMLParserDelegate>
{
	MKMapView* mapViewWeather;
	NSURLConnection* rssConnection;
	NSMutableData* receivedData;	///< received data from server
	
}
- (void) loadWeatherRSS;

@end
