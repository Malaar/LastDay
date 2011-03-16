//
//  MYNewsRSSFeedController.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsRSSFeedController.h"
#import "MYNewsRSSItem.h"

@implementation MYNewsRSSFeedController

@synthesize rssFeed;

//==========================================================================================
- (void) setRssFeed:(MYNewsRSSFeed*) aNewsRssFeed
{
	if(rssFeed != aNewsRssFeed)
	{
		[rssFeed release];
		[aNewsRssFeed retain];
		rssFeed = aNewsRssFeed;
		
		[self.tabBarItem setTitle: aNewsRssFeed.title];
	}
}

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		[self loadRssFeed];
		// ...
	}
	return self;
}


//==========================================================================================
- (void) viewWillAppear: (BOOL)animated
{
	[super viewWillAppear:animated];
	
	// ...
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [news count];
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"newsCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	MYNewsRSSItem* rssItem = [news objectAtIndex:[indexPath row]];
	[cell.textLabel setText: rssItem.title];
	[cell.detailTextLabel setText: rssItem.pubDate];
	return cell;
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// ...
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	[rssFeed release];
	[news release];
	
    [super dealloc];
}

//==========================================================================================
- (void) loadRssFeed
{
	if(news)
		[news release];
	
	news = [[NSMutableArray alloc] init];
	// ...
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
