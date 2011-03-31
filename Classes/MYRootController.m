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
	
	UIImage* image = [UIImage imageNamed:@"earth.png"];
	MYThemeData* themeData = [MYThemeData themeDataWithTitle:@"Earth" image:image];
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
		case 0:
			[self.navigationController pushViewController:[self earthController] animated:YES];
			break;
		case 1:
			//if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
			if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
				[self.navigationController pushViewController: [self photoController] animated: YES];
			break;
		case 2:
			[self.navigationController pushViewController:[self messageController] animated:YES];
			break;
		case 3:
			[self.navigationController pushViewController:[self newsController] animated:YES];
			break;
		case 4:
			[self.navigationController pushViewController:[self exchangeController] animated:YES];
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
	[earthController release];
	[themeArray release];
	[photoController release];
	[newsController release];
	[exchangeController release];
    [super dealloc];
}

//==========================================================================================
- (MYEarthController*) earthController
{
	if(!earthController)
		earthController = [[MYEarthController alloc] init];
	
	return earthController;
}

//==========================================================================================
- (MYMessageController*) messageController
{
	if(!messageController)
		messageController = [[MYMessageController alloc] init];
	
	return messageController;
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
-(MYExchangeController*) exchangeController
{
	if(!exchangeController)
		exchangeController = [[MYExchangeController alloc] init];
	
	return exchangeController;
}
//==========================================================================================
//==========================================================================================


@end
