//
//  MYPhotoController.m
//  LastDay
//
//  Created by Malaar on 19.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYPhotoController.h"
#import "SHKFacebook.h"

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
	//imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
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
	[self postPhotoToFacebook];
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:NO];
}

//==========================================================================================
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:NO];
}

//==========================================================================================
- (IBAction) postPhotoToFacebook
{
	// post photo to Facebook ...
	SHKItem* shkItem = [SHKItem image:image title:@"Almost last photo!"];
	[SHKFacebook shareItem:shkItem];
}

//==========================================================================================
- (IBAction) postPhotoToFlikr
{
	// post photo to Flikr
	assert(0 && "not implement yet");
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
