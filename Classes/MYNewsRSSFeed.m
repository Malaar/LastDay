//
//  MYNewsRSSFeed.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsRSSFeed.h"


@implementation MYNewsRSSFeed

@synthesize title;
@synthesize url;

//==========================================================================================
+ (id) newsRSSFeed
{
	return [[[MYNewsRSSFeed alloc] init] autorelease];
}

//==========================================================================================
+ (id) newsRSSFeedWithTitle: (NSString*)aTitle urlString: (NSString*)aUrlString
{
	return [[[MYNewsRSSFeed alloc] initWithTitle:aTitle urlString:aUrlString] autorelease];
}

//==========================================================================================
- (id) init
{
	return [self initWithTitle:nil urlString:nil];
}

//==========================================================================================
- (id) initWithTitle: (NSString*)aTitle urlString: (NSString*)aUrlString
{
	if(self = [super init])
	{
		self.title = aTitle;
		self.url = [NSURL URLWithString:aUrlString];
	}
	
	return self;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
