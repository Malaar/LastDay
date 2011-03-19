//
//  MYPhotoController.h
//  LastDay
//
//  Created by Malaar on 19.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/// Photo controller - to take photo and post it
@interface MYPhotoController : UIViewController
								<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	UIImage* image;		///< Image from camera
}

- (IBAction) postPhotoToFacebook;
- (IBAction) postPhotoToFlikr;

@end
