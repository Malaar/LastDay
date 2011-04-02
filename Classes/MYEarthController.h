//
//  MYEarthController.h
//  LastDay
//
//  Created by yuriy on 30.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYEarthquaceController.h"
#import "MYWeatherController.h"

@interface MYEarthController : UITableViewController
{
	NSMutableArray* earthThemes;
	
	// controllers
	MYEarthquaceController* earthquaceController;
	MYWeatherController* weatherController;
}


- (MYEarthquaceController*) earthquaceController;
- (MYWeatherController*) weatherController;

@end
