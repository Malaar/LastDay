//
//  MYMessageSender.m
//  LastDay
//
//  Created by Malaar on 23.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessageSender.h"
#import "SHKFacebook.h"
#import "SHKTwitter.h"

static MYMessageSender* sharedSender;

@implementation MYMessageSender

//==========================================================================================
+ (MYMessageSender*) sharedMessageSender
{
	if(!sharedSender)
		sharedSender = [[MYMessageSender alloc] init];

	return sharedSender;
}

//==========================================================================================
- (void) dealloc
{
	[text release];
	[super dealloc];
}

//==========================================================================================
- (void) sendMessage: (NSString*) aText showInView: (UIView*) view
{
	text = aText;
	[text retain];
	
	UIActionSheet* sendSheet = [[[UIActionSheet alloc] initWithTitle:@"Send To"
											delegate:self 
								   cancelButtonTitle:@"Cancel"
							  destructiveButtonTitle:nil
								   otherButtonTitles:@"Facebook", @"Twitter", nil] autorelease];
	
	[sendSheet showInView:view.window];
}

//==========================================================================================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex > 1) return;	// only two button and third - cancel
	
	SHKItem* textItem = [SHKItem text: text];
	
	if(buttonIndex == 0)
	{
		[SHKFacebook shareItem:textItem];
	}
	else if(buttonIndex == 1)
	{
		[SHKTwitter shareItem:textItem];
	}
}


//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
