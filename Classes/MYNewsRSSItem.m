//
//  MYNewsRSSItem.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsRSSItem.h"


@implementation MYNewsRSSItem

@synthesize title;
@synthesize description;
@synthesize link;
@synthesize pubDate;
@synthesize guid;
@synthesize image;

//==========================================================================================
+ (id) newsRSSItem
{
	return [[[MYNewsRSSItem alloc] init] autorelease];
}

//==========================================================================================
+ (id) newsRSSItemWithDictionary: (NSDictionary*)aDictionary
{
	return [[[MYNewsRSSItem alloc] initWithDictionary:aDictionary] autorelease];
}

//==========================================================================================
- (id) init
{
	return [self initWithDictionary:nil];
}

//==========================================================================================
- (id) initWithDictionary: (NSDictionary*)aDictionary
{
	if(self = [super init])
	{
		if(aDictionary)
		{
			self.title       = [aDictionary objectForKey:@"title"];
			self.description = [aDictionary objectForKey:@"description"];
			self.link        = [aDictionary objectForKey:@"link"];
			self.guid        = [aDictionary objectForKey:@"guid"];
			self.pubDate     = [aDictionary objectForKey:@"pubDate"];
		}
	}
	return self;
}

//==========================================================================================
- (void) dealloc
{
	[title release];
	[description release];
	[link release];
	[pubDate release];
	[guid release];

	[super dealloc];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
