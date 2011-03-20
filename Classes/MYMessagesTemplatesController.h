//
//  MYMessagesTemplatesController.h
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MYMessagesTemplatesController : UIViewController
											<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UIToolbar* toolBar;
	IBOutlet UITableView* messagesTableView;
	NSIndexPath* selectedPath;

}

- (void) addNewMessage;
- (void) sendMessage;
- (void) editMessagesTable;

- (void) deselectRow;

@end
