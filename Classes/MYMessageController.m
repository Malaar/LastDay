    //
//  MYMessageController.m
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessageController.h"
#import "MYMessageOwn.h"
#import "MYMessagesTemplatesController.h"

@implementation MYMessageController

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		// navigation bar
		[self setTitle:@"Messages"];

		// create tabs and add it
		NSArray* controllers = [NSArray arrayWithObjects:
								[[[MYMessageOwn alloc] init] autorelease],
								[[[MYMessagesTemplatesController alloc] init] autorelease],
								nil];
		[self setViewControllers:controllers animated:YES];
	}
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];
	
	/*
	UIImage* image = [UIImage imageNamed:@"message.png"];
	UIImageView* view = [[[UIImageView alloc] initWithImage:image] autorelease];
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	self.navigationItem.rightBarButtonItem = bbi;
	//*/
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
//==========================================================================================
//==========================================================================================


@end
