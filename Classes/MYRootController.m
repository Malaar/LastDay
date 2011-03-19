    //
//  MYRootController.m
//  LastDay
//
//  Created by Malaar on 15.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYRootController.h"
#import "MYThemeData.h"


@implementation MYRootController

//==========================================================================================
- (id) init
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	
	// navigation panel
	[self.navigationItem setTitle: @"Themes"];
	
	// set themes
	themeArray = [[NSMutableArray alloc] init];
	
	UIImage* image = [UIImage imageNamed:@"weather.png"];
	MYThemeData* themeData = [MYThemeData themeDataWithTitle:@"Weather" image:image];
	[themeArray addObject:themeData];
	
	image = [UIImage imageNamed:@"camera.png"];
	themeData = [MYThemeData themeDataWithTitle:@"Take photo" image:image];	
	[themeArray addObject:themeData];

	image = [UIImage imageNamed:@"message.png"];
	themeData = [MYThemeData themeDataWithTitle:@"Send message" image:image];
	[themeArray addObject:themeData];

	image = [UIImage imageNamed:@"news.png"];
	themeData = [MYThemeData themeDataWithTitle:@"News" image:image];
	[themeArray addObject:themeData];

	image = [UIImage imageNamed:@"exchange_rate.png"];
	themeData = [MYThemeData themeDataWithTitle:@"Exchange rate" image:image];
	[themeArray addObject:themeData];
	
	return self;
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
	//return [themeArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [themeArray count];
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
	
	MYThemeData* themeData = [themeArray objectAtIndex:[indexPath section]];
	[cell.textLabel setText: themeData.title];
	[cell.imageView setImage: themeData.image];
	return cell;
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch([indexPath section])
	{
		case 1:
			//if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
				[self.navigationController pushViewController: [self photoController] animated: YES];
			break;
		case 3:
			[self.navigationController pushViewController:[self newsController] animated:YES];
			break;
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//==========================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//==========================================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
}


//==========================================================================================
- (void)dealloc 
{
	[themeArray release];
	[photoController release];
	[newsController release];
    [super dealloc];
}

//==========================================================================================
- (MYPhotoController*) photoController
{
	if(!photoController)
		photoController = [[MYPhotoController alloc] init];
	
	return photoController;
}

//==========================================================================================
-(MYNewsController*) newsController
{
	if(!newsController)
		newsController = [[MYNewsController alloc] init];
	
	return newsController;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
