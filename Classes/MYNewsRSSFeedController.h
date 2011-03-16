//
//  MYNewsRSSFeedController.h
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYNewsRSSFeed.h"

@interface MYNewsRSSFeedController : UITableViewController
{
	MYNewsRSSFeed* rssFeed;			///< rss feed
	NSMutableArray* news;			///< news info
}

@property (nonatomic, retain) MYNewsRSSFeed* rssFeed;

- (void) loadRssFeed;

@end
