//
//  MYPhotoController.m
//  LastDay
//
//  Created by Malaar on 19.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYPhotoController.h"


@implementation MYPhotoController

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		[self setTitle:@"Post photo"];
	}
	return self;
}

//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if(image)
	{
		[image release];
		image = nil;
	}
	
	//*
	UIImagePickerController* imagePicker = [[[UIImagePickerController alloc] init] autorelease];
	[imagePicker setDelegate: self];
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	[self presentModalViewController:imagePicker animated:NO];
	//*/
}

//==========================================================================================
- (void)dealloc
{
	[image release];
    [super dealloc];
}

//==========================================================================================
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[image retain];
	[self dismissModalViewControllerAnimated:YES];
}

//==========================================================================================
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self.navigationController popViewControllerAnimated:YES];
}

//==========================================================================================
- (IBAction) postPhotoToFacebook
{
	// post photo to Facebook ...
}

//==========================================================================================
- (IBAction) postPhotoToFlikr
{
	// post photo to Flikr
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
