//
//  MYMessageOwn.m
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessageOwn.h"
#import "MYMessageSender.h"

@implementation MYMessageOwn

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		[self.tabBarItem setTitle:@"New"];
	}
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:3];
	UIBarButtonItem* bbi;

	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														target:nil
														action:nil] autorelease];
	[toolBarItems addObject:bbi];

	// item: send message
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone
										  target:self
										  action:@selector(sendMessage)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: cancel editing 
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																		 target:self
																		 action:@selector(cancelEditMessage)] autorelease];
	[toolBarItems addObject: bbi];

	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	[toolBar setItems:toolBarItems animated:YES];
}

//==========================================================================================
- (void) viewWillDisappear: (BOOL)animated
{
	[super viewWillDisappear:animated];
	[tvMessage resignFirstResponder];
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
	[tvMessage release];
	tvMessage = nil;
	[toolBar release];
	toolBar = nil;
}


//==========================================================================================
- (void)dealloc
{
	[tvMessage release];
	[toolBar release];
    [super dealloc];
}

//==========================================================================================
- (void) sendMessage
{
	// let's try to send message
	NSString* checkText = [tvMessage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([checkText length])
	{
		[tvMessage resignFirstResponder];
		[[MYMessageSender sharedMessageSender] sendMessage:tvMessage.text showInView:self.view];
	}
	else
	{
		tvMessage.text = nil;
	}
}

//==========================================================================================
- (void) cancelEditMessage
{
	[tvMessage resignFirstResponder];
	tvMessage.text = nil;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
