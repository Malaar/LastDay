    //
//  MYEarthController.m
//  LastDay
//
//  Created by yuriy on 30.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYEarthController.h"
#import "MYThemeData.h"

@implementation MYEarthController

//==========================================================================================
- (id) init
{
	if(self = [super initWithStyle:UITableViewStyleGrouped])
	{
		earthThemes = [[NSMutableArray alloc] initWithCapacity:4];
		
		[self setTitle:@"Earth"];
		
		MYThemeData* themeData;
		UIImage* image;
		
		image = [UIImage imageNamed:@"weather.png"];
		themeData = [MYThemeData themeDataWithTitle:@"Weather" image:image];
		[earthThemes addObject:themeData];
		
		image = [UIImage imageNamed:@"earthquace.png"];
		themeData = [MYThemeData themeDataWithTitle:@"Earthquace" image:image];
		[earthThemes addObject:themeData];
	}
	return self;
}

//- (void) viewWillDisappear:(BOOL)animated
//{
//}

//==========================================================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [earthThemes count];
}

//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"earthCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
	}
	//
	MYThemeData* themeData = [earthThemes objectAtIndex:[indexPath section]];
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
			break;
		case 1:
			[self.navigationController pushViewController:[self earthquaceController] animated:YES];
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
	[earthThemes release];
	[earthquaceController release];
	
    [super dealloc];
}

- (MYEarthquaceController*) earthquaceController
{
	if(!earthquaceController)
		earthquaceController = [[MYEarthquaceController alloc] init];
	
	return earthquaceController;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
