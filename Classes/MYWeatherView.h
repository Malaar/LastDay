//
//  MYWeatherView.h
//  MapTest_001
//
//  Created by Malaar on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYWeather.h"

@interface MYWeatherView : UIView
{
	UIImageView* imageWeather;
	UILabel* lbLocation;
	UILabel* lbTempHumPres;		// for temperature, humidity and pressure
	UILabel* lbWindInfo;

	
	MYWeather* weatherInfo;
}

@property (nonatomic, copy) MYWeather* weatherInfo;

+ (id) weatherView;
- (id) init;

- (void) updateInfo;

@end
