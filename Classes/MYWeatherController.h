//
//  MYWeatherController.h
//  LastDay
//
//  Created by yuriy on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MYWeather.h"
#import "MYWeatherView.h"

@interface MYWeatherController : UIViewController <MKMapViewDelegate>
{
	MKMapView* mapViewWeather;
	NSURLConnection* rssConnection;
	NSMutableData* receivedData;	///< received data from server
	MYWeatherView* weatherView;

	MYWeather* weather; 
}

@property (nonatomic, retain) MYWeather* weather;
- (void) loadWeatherRSS;
- (void) showWeatherInCurrLocation;

@end
