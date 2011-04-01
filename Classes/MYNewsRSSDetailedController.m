//
//  MYNewsRSSDetailedController.m
//  LastDay
//
//  Created by Malaar on 17.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsRSSDetailedController.h"


@implementation MYNewsRSSDetailedController

@synthesize rssItem;

//==========================================================================================
- (id) init
{
	if(self = [super initWithNibName:nil bundle:nil])
	{
		[self setTitle:@"Detailed news"];
	}
	return self;
}

//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	textView.editable = FALSE;
	
	NSMutableString* detailedStr = [NSMutableString stringWithString: rssItem.description];
	[detailedStr appendString:@"\n\n"];
	[detailedStr appendString: rssItem.pubDate];
	[lbTitle setText:rssItem.title];
	[textView setText: detailedStr];
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
	[lbTitle release];
	lbTitle = nil;
	[textView release];
	textView = nil;
}

//==========================================================================================
- (void)dealloc
{
	[textView release];
	[lbTitle release];
	
    [super dealloc];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
