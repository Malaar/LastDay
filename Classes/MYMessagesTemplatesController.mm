    //
//  MYMessagesTemplatesController.m
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessagesTemplatesController.h"
#import "MYMessageSender.h"
#import "tinyxml.h"

@implementation MYMessagesTemplatesController

//==========================================================================================
- (id) init
{
	if(self = [super initWithNibName:nil bundle:nil])
	{
		[self.tabBarItem setTitle:@"Templates"];
		[self.tabBarItem setImage:nil];
		// load messages templates
		[self loadMessagesTemplates];
		//
		NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self
							   selector:@selector(needSaveNotification:)
								   name:UIApplicationWillTerminateNotification
								 object:nil];
		[notificationCenter addObserver:self
							   selector:@selector(needSaveNotification:)
								   name:UIApplicationDidEnterBackgroundNotification
								 object:nil];
		
		//
		appearType = MYMessagesTemplatesControllerAppearTypeNone;
		searching = FALSE;
	}
	
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];

	[messagesTableView setDelegate:self];
	[messagesTableView setDataSource:self];
	[searchBar setDelegate:self];
	searchBar.showsCancelButton = TRUE;
	
	UIBarButtonItem* bbi;

//	// item: send 
//	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone
//										   target:self
//										   action:@selector(sendMessage)] autorelease];
//	[[[self parentViewController] navigationItem] setRightBarButtonItem:bbi];
	
	// add items to the toolbar
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:6];

	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: add new message template
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered
										   target:self
										   action:@selector(addNewMessage)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	

	// item: edit 
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered
										   target:self
										   action:@selector(editMessagesTable)] autorelease];
	[toolBarItems addObject: bbi];
	editButton = bbi;
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	
	[toolBar setItems:toolBarItems animated:YES];
}

//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	// item: send 
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone
										   target:self
										   action:@selector(sendMessage)] autorelease];
	[[[self parentViewController] navigationItem] setRightBarButtonItem:bbi];

	[super viewWillAppear:animated];
	
	if(appearType == MYMessagesTemplatesControllerAppearTypeAfterAdd)
	{
		if([self messageDetailedController].needSave)
		{
			NSString* newString = [self messageDetailedController].messageText;
			[messages addObject:newString];
			[messagesTableView reloadData];
		}
	}
	else if(appearType == MYMessagesTemplatesControllerAppearTypeAfterEdit)
	{
		if([self messageDetailedController].needSave)
		{
			NSString* newString = [[self messageDetailedController].messageText retain];
			[messages replaceObjectAtIndex:editedIndex withObject:newString];
			[messagesTableView reloadData];
		}
	}
	
	appearType = MYMessagesTemplatesControllerAppearTypeNone;
	editedIndex = (NSUInteger)-1;
}

//==========================================================================================
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[self deselectRow];
	[self cancelSearching];
}

//==========================================================================================
- (void) viewDidUnload
{
	[super viewDidUnload];

	[toolBar release];
	toolBar = nil;
	[messagesTableView release];
	messagesTableView = nil;
	[searchBar release];
	searchBar = nil;
	[self deselectRow];
}

//==========================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//==========================================================================================
- (void)dealloc
{
	[messageDetailedController release];
	[toolBar release];
	[messagesTableView release];
	[searchBar release];
	[messages release];
	[filteredMessages release];
    [super dealloc];
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray* source = (searching) ? (filteredMessages) : (messages);
	return [source count];
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"messagesCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];//DisclosureIndicator];
	}
	
	NSArray* source = (searching) ? (filteredMessages) : (messages);
	
	//cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
	NSString* templateMessage = [source objectAtIndex: [indexPath row]];
	[cell.textLabel setText: templateMessage];

	return cell;
}

/*
//==========================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(searching)
		[self cancelSearching];
}
//*/

//==========================================================================================
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSIndexPath* selectedPath = [messagesTableView indexPathForSelectedRow];
	if(indexPath != selectedPath)
		[self deselectRow];
	
	[self messageDetailedController].messageText = [messages objectAtIndex:[indexPath row]];
	[self.navigationController pushViewController: [self messageDetailedController] animated:YES];
	appearType = MYMessagesTemplatesControllerAppearTypeAfterEdit;
	editedIndex = [indexPath row];
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle == UITableViewCellEditingStyleDelete)
	{
		[messages removeObjectAtIndex:[indexPath row]];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
	}
}

//==========================================================================================
- (void) sendMessage
{
	NSIndexPath* selectedPath = [messagesTableView indexPathForSelectedRow];
	if(!selectedPath) return;
	
	[self deselectRow];
	[self cancelSearching];
	// let's send message
	NSArray* source = (searching) ? (filteredMessages) : (messages);
	NSString* messageText = [source objectAtIndex: [selectedPath row]];
	
	if([messageText length])
	{
		[[MYMessageSender sharedMessageSender] sendMessage:messageText showInView:self.view];
	}
}

//==========================================================================================
- (void) addNewMessage
{
	[self messageDetailedController].messageText = @"";
	[self.navigationController pushViewController:[self messageDetailedController] animated:YES];
	appearType = MYMessagesTemplatesControllerAppearTypeAfterAdd;
}

//==========================================================================================
- (void) editMessagesTable
{
	[self deselectRow];
	if([messagesTableView isEditing])
	{
		[messagesTableView setEditing:FALSE animated:NO];
		[editButton setTitle:@"Edit"];
	}
	else
	{		
		[messagesTableView setEditing:TRUE animated:YES];
		[editButton setTitle:@"Done"];
	}

	// ...
}

//==========================================================================================
- (void) deselectRow
{
 	NSIndexPath* selectedPath = [messagesTableView indexPathForSelectedRow];
	if(selectedPath)
	{
		[messagesTableView deselectRowAtIndexPath:selectedPath animated:YES];
		//[selectedPath release];
		//selectedPath = nil;
	}
}

//==========================================================================================
- (BOOL) loadMessagesTemplates
{
	BOOL result = FALSE;
	[messages release];
	messages = [[NSMutableArray alloc] init];

	TiXmlDocument domDocument;

	const char* messagesPath;

	// try to load from Documents/ directory:
	NSString* strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	strPath = [strPath stringByAppendingPathComponent:@"messTemplates.xml"];

	if( [[NSFileManager defaultManager] fileExistsAtPath:strPath] )
	{
		messagesPath = [strPath UTF8String];
	}
	else
	{
		// load default messages from bundle
		messagesPath = [[[NSBundle mainBundle] pathForResource:@"messTemplates" ofType:@"xml"] UTF8String];
	}

	if( messagesPath && domDocument.LoadFile(messagesPath) )
	{
		TiXmlElement* rootNode = domDocument.RootElement();
		TiXmlElement* itemNode = rootNode->FirstChildElement("item");
		while(itemNode)
		{
			NSString* templateMessage = [NSString stringWithUTF8String: itemNode->GetText()];
			[messages addObject: templateMessage];
			
			itemNode = itemNode->NextSiblingElement("item");
		}
	}
	return result;
}

//==========================================================================================
- (void) saveMessagesTemplates
{
	if(!messages)
		return;
	
	TiXmlDocument domDocument;
	TiXmlElement* rootNode = new TiXmlElement("templates");
	
	for(int i = 0; i < [messages count]; ++i)
	{
		TiXmlElement* itemNode = new TiXmlElement("item");
		TiXmlText* text = new TiXmlText( [[messages objectAtIndex:i] UTF8String] );
		itemNode->LinkEndChild(text);
		rootNode->LinkEndChild(itemNode);
	}
	domDocument.LinkEndChild(rootNode);

	// save into the Documents/ directory
	NSString* messagesPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	const char* strPath = [[messagesPath stringByAppendingPathComponent:@"messTemplates.xml"] UTF8String];
	domDocument.SaveFile(strPath);
}

//==========================================================================================
- (void) needSaveNotification: (NSNotification*) notification
{
	[self saveMessagesTemplates];
}

//==========================================================================================
- (MYMessageDetailedController*) messageDetailedController
{
	if(!messageDetailedController)
		messageDetailedController = [[MYMessageDetailedController alloc] init];
	
	return messageDetailedController;
}

//==========================================================================================
- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
{
	[self cancelSearching];
}

//==========================================================================================
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	//searching = YES;
}

//==========================================================================================
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if( [searchText length] )
	{
		searching = YES;
		
		if(filteredMessages)
			[filteredMessages release];
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(SELF contains[cd] %@)", searchText];
		filteredMessages = [messages filteredArrayUsingPredicate:predicate];
		[filteredMessages retain];
	}
	else
	{
		searching = NO;
	}

	[messagesTableView reloadData];
}

//==========================================================================================
- (void) cancelSearching
{
	searching = NO;
	searchBar.text = @"";
	[searchBar resignFirstResponder];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
