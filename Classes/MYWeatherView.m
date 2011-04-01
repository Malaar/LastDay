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
		weatherInfo = aWeather;
		[weatherInfo retain];
		
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
	lbLocation = [[[UILabel alloc] initWithFrame:CGRectMake(0,0, screenBounds.size.width, 35)] autorelease];
	lbLocation.textAlignment = UITextAlignmentCenter;
	lbLocation.text = weatherInfo.strLocation;
	lbLocation.backgroundColor = [UIColor clearColor];
	lbLocation.textColor = [UIColor whiteColor];
	lbLocation.font = [UIFont boldSystemFontOfSize:20];
	[self addSubview:lbLocation];

	// image
	[imageWeather release];
	imageWeather = [[[UIImageView alloc] initWithImage:weatherInfo.weatherImage] autorelease];
	[imageWeather setFrame: CGRectMake(screenBounds.size.width - weatherInfo.weatherImage.size.width, 40, imageWeather.frame.size.width, imageWeather.frame.size.height)];
	[self addSubview:imageWeather];
	
	// lbTempHumPres
	[lbTempHumPres release];
	lbTempHumPres = [[[UILabel alloc] initWithFrame:CGRectMake(10, 40, screenBounds.size.width, 25)] autorelease];
	lbTempHumPres.text = [NSString stringWithFormat:@"%.1fC; %.1f %%; %.1f In", 
						  weatherInfo.temperature,
						  weatherInfo.humidity,
						  weatherInfo.pressureIn];
	lbTempHumPres.backgroundColor = [UIColor clearColor];
	lbTempHumPres.textColor = [UIColor whiteColor];
	lbTempHumPres.font = [UIFont boldSystemFontOfSize:18];
	[self addSubview:lbTempHumPres];

	// wind info
	[lbWindInfo release];
	lbWindInfo = [[[UILabel alloc] initWithFrame:CGRectMake(10, 70, screenBounds.size.width, 25)] autorelease];
	lbWindInfo.text = [NSString stringWithFormat:@"%@, %.2f mph", weatherInfo.windDir, weatherInfo.windSpeed];
	lbWindInfo.backgroundColor = [UIColor clearColor];
	lbWindInfo.textColor = [UIColor whiteColor];
	lbWindInfo.font = [UIFont boldSystemFontOfSize:18];
	[self addSubview:lbWindInfo];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
