//
//  MYMessageOwn.h
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MYMessageOwn : UIViewController
{
	IBOutlet UITextView* tvMessage;		///< textView for new sending message
	IBOutlet UIToolbar* toolBar;		///< tool bar...
}

- (void) sendMessage;
- (void) cancelEditMessage;

@end
