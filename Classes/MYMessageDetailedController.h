//
//  MYMessageDetailed.h
//  LastDay
//
//  Created by Malaar on 24.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MYMessageDetailedController : UIViewController <UITextViewDelegate>
{
	IBOutlet UITextView* tvMessage;			///< text view to display detailed message (editing or adding)
	IBOutlet UILabel* lbRemainLetters;		///< lebel to display remaining amount of letters in message
	NSString* messageText;					///< messsage text to display in tvMessage
	BOOL needSave;							///< mark if need save message
}

@property (nonatomic, retain) NSString* messageText;
@property (nonatomic, readonly) BOOL needSave;

- (void) saveMessageText;
- (void) updateRemainLetter;

@end
