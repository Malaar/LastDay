//
//  MYNewsRSSFeedController.h
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYNewsRSSFeed.h"
#import "MYNewsRSSDetailedController.h"

@interface MYNewsRSSFeedController : UITableViewController
{
	MYNewsRSSFeed* rssFeed;			///< rss feed
	NSMutableArray* news;			///< news info
	NSURLConnection* rssConnection;
	NSMutableData* receivedData;	///< received data from server
	
	MYNewsRSSDetailedController* detailedController;
}

@property (nonatomic, retain) MYNewsRSSFeed* rssFeed;

- (void) loadRssFeed;

@end
