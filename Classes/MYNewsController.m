    //
//  MYNewsController.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsController.h"


@implementation MYNewsController

- (id) init
{
	if(self = [super init])
	{
		// navigation panel
		[self setTitle:@"News"];
	}
	return self;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	UIImage* image = [UIImage imageNamed:@"news.png"];
	UIImageView* view = [[[UIImageView alloc] initWithImage:image] autorelease];
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	self.navigationItem.rightBarButtonItem = bbi;
	//[self.navigationItem.titleView addSubview:view];
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"rootCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	//MYThemeData* themeData = [themeArray objectAtIndex:[indexPath section]];
	//[cell.textLabel setText: themeData.title];
	//[cell.imageView setImage: themeData.image];
	return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)dealloc
{
    [super dealloc];
}


@end
