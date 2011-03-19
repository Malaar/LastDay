//
//  MYRootController.h
//  LastDay
//
//  Created by Malaar on 15.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPhotoController.h"
#import "MYNewsController.h"


@interface MYRootController : UITableViewController
{
	NSMutableArray* themeArray;

	// controllers
	MYPhotoController* photoController;
	MYNewsController* newsController;
}

- (MYPhotoController*) photoController;
-(MYNewsController*) newsController;

@end
