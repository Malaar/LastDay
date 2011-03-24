//
//  MYMessageDetailed.m
//  LastDay
//
//  Created by Malaar on 24.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessageDetailedController.h"

static const int twitterLettersLimit = 140;

@implementation MYMessageDetailedController

@synthesize messageText;
@synthesize needSave;

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
																		 target:self
																		  action:@selector(saveMessageText)] autorelease];
		self.navigationItem.rightBarButtonItem = bbi;
	}
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];
	[tvMessage setDelegate:self];
}

//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	needSave = FALSE;
	tvMessage.text = messageText;
	[self updateRemainLetter];
}

//==========================================================================================
- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[tvMessage becomeFirstResponder];
}

//==========================================================================================
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[tvMessage resignFirstResponder];
}

//==========================================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
	[tvMessage release];
	tvMessage = nil;
	[lbRemainLetters release];
	lbRemainLetters = nil;
}

//==========================================================================================
- (void)dealloc
{
	[tvMessage release];
	[lbRemainLetters release];
	
    [super dealloc];
}

//==========================================================================================
- (void) saveMessageText
{
	NSString* checkText = [tvMessage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([checkText length])
	{
		needSave = [messageText length];
		if(needSave)
		{
			self.messageText = tvMessage.text;
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
}

//==========================================================================================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	NSUInteger textLength = [tvMessage.text length];
	return textLength < twitterLettersLimit;
}

//==========================================================================================
- (void)textViewDidChange:(UITextView *)textView
{
	[self updateRemainLetter];
}

//==========================================================================================
- (void) updateRemainLetter
{
	NSUInteger textLength = [tvMessage.text length];
	lbRemainLetters.text = [NSString stringWithFormat:@"%i", twitterLettersLimit - textLength];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
