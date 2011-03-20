    //
//  MYMessagesTemplatesController.m
//  LastDay
//
//  Created by Malaar on 20.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMessagesTemplatesController.h"


@implementation MYMessagesTemplatesController

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		[self.tabBarItem setTitle:@"Templates"];
		[self.tabBarItem setImage:nil];
	}
	
	return self;
}

//==========================================================================================
- (void) viewDidLoad
{
	[super viewDidLoad];

	[messagesTableView setDelegate:self];
	[messagesTableView setDataSource:self];
	
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:3];
	
	UIBarButtonItem* bbi;

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
	
	// item: send 
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone
										   target:self
										   action:@selector(sendMessage)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: cancel editing 
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered
										   target:self
										   action:@selector(editMessagesTable)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	
	[toolBar setItems:toolBarItems animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[self deselectRow];
}

//==========================================================================================
- (void) viewDidUnload
{
	[super viewDidUnload];

	[toolBar release];
	toolBar = nil;
	[messagesTableView release];
	messagesTableView = nil;
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
	[toolBar release];
	[messagesTableView release];
    [super dealloc];
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;//[news count];
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"messagesCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];

		/*
		UIButton* btnAccessory = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		CGRect frame = CGRectMake(0, 0, 75, 25);
		btnAccessory.frame = frame;
		[btnAccessory setTitle:@"Send" forState:UIControlStateNormal];
		[btnAccessory addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
		[cell setAccessoryView:btnAccessory];
		//*/
		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];//DisclosureIndicator];
	}
	
	//cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
	
	[cell.textLabel setText: @"~~~"];

	return cell;
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedPath = indexPath;
	[selectedPath retain];
}

//*
//==========================================================================================
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(indexPath != selectedPath)
		[self deselectRow];
}
//*/

//==========================================================================================
- (void) sendMessage
{
	if(!selectedPath) return;
	
	[self deselectRow];
	// ...
}

//==========================================================================================
- (void) addNewMessage
{
	[self deselectRow];
	// ...
}

//==========================================================================================
- (void) editMessagesTable
{
	[self deselectRow];
	// ...
}

//==========================================================================================
- (void) deselectRow
{
	if(selectedPath)
	{
		[messagesTableView deselectRowAtIndexPath:selectedPath animated:YES];
		[selectedPath release];
		selectedPath = nil;
	}
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
