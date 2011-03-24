//
//  MYMessageSender.h
//  LastDay
//
//  Created by Malaar on 23.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/// To send text message on Twitter and Facebook
@interface MYMessageSender : NSObject <UIActionSheetDelegate>
{
	NSString* text;		///< text to send
}

+ (MYMessageSender*) sharedMessageSender;
- (void) sendMessage: (NSString*) aText showInView: (UIView*) view;

@end
