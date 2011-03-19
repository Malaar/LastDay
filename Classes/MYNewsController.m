    //
//  MYNewsController.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsController.h"
#import "JSON.h"
#import "MYNewsRSSFeed.h"
#import "MYNewsRSSFeedController.h"

@implementation MYNewsController

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		// navigation panel
		[self setTitle:@"News"];
		
		// tab bar items
		NSMutableArray* rssFeeds = [self getRSSFeeds];
		if(rssFeeds && [rssFeeds count])
		{
			NSMutableArray* feedControllers = [NSMutableArray arrayWithCapacity:[rssFeeds count]];

			for(MYNewsRSSFeed* feed in rssFeeds)
			{
				MYNewsRSSFeedController* feedController = [[[MYNewsRSSFeedController alloc] init] autorelease];
				feedController.rssFeed = feed;
				[feedControllers addObject:feedController];
			}

			[self setViewControllers: feedControllers animated:YES];
		}
		
	}
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];
	
	UIImage* image = [UIImage imageNamed:@"news.png"];
	UIImageView* view = [[[UIImageView alloc] initWithImage:image] autorelease];
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	self.navigationItem.rightBarButtonItem = bbi;
}

//==========================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//==========================================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
}


//==========================================================================================
- (void)dealloc
{
    [super dealloc];
}

//==========================================================================================
// load rss feeds from json
- (NSMutableArray*) getRSSFeeds
{
	NSMutableArray* feeds = [NSMutableArray arrayWithCapacity:8];
	NSString* rssFeedFilePath = [[NSBundle mainBundle] pathForResource:@"NewsRSSFeed" ofType:@"json"];
	
	NSData* rssFeedData = [NSData dataWithContentsOfFile:rssFeedFilePath];
	SBJsonParser* jsonParser = [[[SBJsonParser alloc] init] autorelease];
	NSArray* rssFeeds = [jsonParser objectWithData:rssFeedData];
	for(NSDictionary* feedDictionary in rssFeeds)
	{
		MYNewsRSSFeed* rssFeed = [MYNewsRSSFeed newsRSSFeedWithTitle: [feedDictionary objectForKey:@"feedTitle"]
														   urlString: [feedDictionary objectForKey:@"rssURL"]
								 ];
		[feeds addObject:rssFeed];
	}
	return feeds;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
