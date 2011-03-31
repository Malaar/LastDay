//
//  MYEarthController.h
//  LastDay
//
//  Created by yuriy on 30.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYEarthquaceController.h"

@interface MYEarthController : UITableViewController
{
	NSMutableArray* earthThemes;
	
	// controllers
	MYEarthquaceController* earthquaceController;
}

- (MYEarthquaceController*) earthquaceController;


@end
