    //
//  MYWeatherView.m
//  MapTest_001
//
//  Created by Malaar on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYWeatherView.h"


@implementation MYWeatherView

@synthesize weatherInfo;

//==========================================================================================
- (void) setWeatherInfo:(MYWeather *) aWeather
{
	if(aWeather != weatherInfo)
	{
		[weatherInfo release];
		weatherInfo = [aWeather copy];
		[self updateInfo];
	}
}

//==========================================================================================
+ (id) weatherView
{
	return [[[MYWeatherView alloc] init] autorelease];
}

//==========================================================================================
- (id) init
{
	if(self = [super initWithFrame: [UIScreen mainScreen].bounds])
	{
		self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		self.userInteractionEnabled = YES;
		//

	}
	return self;
}

//==========================================================================================
- (void)dealloc
{
	[lbLocation release];
	[lbTempHumPres release];
	[lbWindInfo release];
	[weatherInfo release];
	
    [super dealloc];
}

//==========================================================================================
- (void) updateInfo
{
	CGRect screenBounds = [UIScreen mainScreen].bounds;
	
	// location
	[lbLocation release];
	lbLocation = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screenBounds.size.width, 35)];
	lbLocation.textAlignment = UITextAlignmentCenter;
	lbLocation.text = weatherInfo.strLocation;

	// image
	[imageWeather release];
	imageWeather = [[UIImageView alloc] initWithImage:weatherInfo.weatherImage];
	[imageWeather setFrame: CGRectMake(screenBounds.size.width - weatherInfo.weatherImage.size.width, 40, imageWeather.frame.size.width, imageWeather.frame.size.height)];
	
	// lbTempHumPres
	[lbTempHumPres release];
	lbTempHumPres = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, screenBounds.size.width, 25)];
	lbTempHumPres.text = [NSString stringWithFormat:@"%.1fC; %.1f %%; %.1f In", 
						  weatherInfo.temperature,
						  weatherInfo.humidity,
						  weatherInfo.pressureIn];

	// wind info
	[lbWindInfo release];
	lbWindInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, screenBounds.size.width, 25)];
	lbWindInfo.text = [NSString stringWithFormat:@"%@, %.2f mph", weatherInfo.windDir, weatherInfo.windSpeed];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
