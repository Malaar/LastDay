//
//  MYMessagesTemplatesController.h
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYMessageDetailedController.h"

enum MYMessagesTemplatesControllerAppearType
{
	MYMessagesTemplatesControllerAppearTypeNone,
	MYMessagesTemplatesControllerAppearTypeAfterAdd,
	MYMessagesTemplatesControllerAppearTypeAfterEdit
};
typedef enum MYMessagesTemplatesControllerAppearType MYMessagesTemplatesControllerAppearType;


@interface MYMessagesTemplatesController : UIViewController
											<UITableViewDelegate, UITableViewDataSource>
{
	MYMessageDetailedController* messageDetailedController;
	IBOutlet UIToolbar* toolBar;
	IBOutlet UITableView* messagesTableView;
	//NSIndexPath* selectedPath;
	NSMutableArray* messages;
	UIBarButtonItem* editButton;
	NSUInteger editedIndex;
	
	MYMessagesTemplatesControllerAppearType appearType;
}

- (BOOL) loadMessagesTemplates;
- (void) saveMessagesTemplates;

- (MYMessageDetailedController*) messageDetailedController;

- (void) addNewMessage;
- (void) sendMessage;
- (void) editMessagesTable;

- (void) deselectRow;

- (void) needSaveNotification: (NSNotification*) notification;

@end
