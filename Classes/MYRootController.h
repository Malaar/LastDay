//
//  MYRootController.h
//  LastDay
//
//  Created by Malaar on 15.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYMessageController.h"
#import "MYPhotoController.h"
#import "MYNewsController.h"
#import "MYExchangeController.h"
#import "MYEarthController.h"

@interface MYRootController : UITableViewController
{
	NSMutableArray* themeArray;

	// controllers
	MYEarthController* earthController;
	MYMessageController* messageController;
	MYPhotoController* photoController;
	MYNewsController* newsController;
	MYExchangeController* exchangeController;
}

- (MYEarthController*) earthController;
- (MYMessageController*) messageController;
- (MYPhotoController*) photoController;
- (MYNewsController*) newsController;
- (MYExchangeController*) exchangeController;
@end
