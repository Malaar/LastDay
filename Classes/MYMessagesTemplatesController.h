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
											<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
	MYMessageDetailedController* messageDetailedController;
	IBOutlet UIToolbar* toolBar;
	IBOutlet UITableView* messagesTableView;
	IBOutlet UISearchBar* searchBar;
	NSMutableArray* messages;
	NSArray* filteredMessages;
	UIBarButtonItem* editButton;
	NSUInteger editedIndex;
	BOOL searching;
	
	MYMessagesTemplatesControllerAppearType appearType;
}

- (BOOL) loadMessagesTemplates;
- (void) saveMessagesTemplates;

- (MYMessageDetailedController*) messageDetailedController;

- (void) addNewMessage;
- (void) sendMessage;
- (void) editMessagesTable;

- (void) deselectRow;
- (void) cancelSearching;

- (void) needSaveNotification: (NSNotification*) notification;

@end
