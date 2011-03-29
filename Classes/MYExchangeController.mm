    //
//  MYExchangeController.m
//  LastDay
//
//  Created by yuriy on 25.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYExchangeController.h"
#import "MYExchangeNameCyrrency.h"
#import "MYExchangeDataCyrrency.h"
#import "tinyxml.h"

@implementation MYExchangeController

//==========================================================================================
@synthesize namesCyrrency;
//==========================================================================================
- (id) init
{
	if(self = [super initWithNibName:nil bundle:nil])
	{
		[self.navigationItem setTitle : @"Exchange rate"];		
		[self loadNameCurrency];
		[self loadDataCyrrency];
	}
	return self;
}
//==========================================================================================
- (void)viewDidLoad 
{
	[super viewDidLoad];	
	[exchangeTableView setDelegate:self];
	[exchangeTableView setDataSource: self];
	
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:3];
	UIBarButtonItem* bbi;
	
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
														target:nil 
														action:nil] autorelease];
	self.navigationItem.rightBarButtonItem = bbi;
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: send message
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered 
														target:self
														action:@selector(actionAddDataCyrrency)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: cancel editing 
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered
														 target:self
														 action:@selector(editExchangeTableView)] autorelease];
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
-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if ([[self chooseCurrencyController] typeAction] == actionAddNewCurrency) 
	{
		NSMutableArray* newDataCurrency = [[self chooseCurrencyController] newCurrency];
		for (int i = 0; i < [newDataCurrency count]; i++) 
		{
			[dataCyrrency addObject:[newDataCurrency objectAtIndex:i]];
		}
		[exchangeTableView reloadData];
		[[self chooseCurrencyController] setTypeAction: actionNoTupe];
	}	
}
//==========================================================================================
- (void) viewDidUnload
{
	[super viewDidUnload];
	
	[toolBar release];
	toolBar = nil;	
	[exchangeTableView release];
	exchangeTableView = nil;
}
//==========================================================================================
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
//==========================================================================================
- (void)dealloc 
{
	[exchangeTableView release];
	[toolBar release];
	[editButton release];
	[namesCyrrency release];
	[dataCyrrency release];
	[lastDataUpdata release];
    [super dealloc];
}
//==========================================================================================
-(void)actionAddDataCyrrency
{
	[[self chooseCurrencyController]
	 setTypeAction: actionAddNewCurrency];
	[self.navigationController pushViewController: [self chooseCurrencyController] animated:YES];
}
//==========================================================================================
-(void)actionCorrectDataCyrrency
{
	[[self chooseCurrencyController] setTypeAction: actionCorrektCurrency];
	[self.navigationController pushViewController: [self chooseCurrencyController] animated:YES];
}
//==========================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [dataCyrrency count];
}
//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"exchangeCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	}
	NSString* templateMessage = [[dataCyrrency objectAtIndex: [indexPath row] ] fullInfo];
	[cell.textLabel setText: templateMessage];
	return cell;
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.navigationController pushViewController: [self chooseCurrencyController] animated:YES];
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		[dataCyrrency removeObjectAtIndex:[indexPath row]];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
						 withRowAnimation: UITableViewRowAnimationFade];
	}
}
//==========================================================================================
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	MYExchangeNameCyrrency *p = [dataCyrrency objectAtIndex:[fromIndexPath row]];
	[p retain];
	[dataCyrrency removeObjectAtIndex:[fromIndexPath row]];
	[dataCyrrency insertObject:p atIndex:[toIndexPath row]];
	[p release];
}
//==========================================================================================
-(MYExchangeChooseCurrencyController*) chooseCurrencyController
{
	if(!chooseCurrencyController)
	{
		chooseCurrencyController = [[MYExchangeChooseCurrencyController alloc]init];
		chooseCurrencyController.namesCurrency = namesCyrrency;
	}
	return chooseCurrencyController;
}

//==========================================================================================
- (void) editExchangeTableView
{
	if([exchangeTableView isEditing])
	{
		[exchangeTableView setEditing:FALSE animated:NO];
		[editButton setTitle:@"Edit"];
	}
	else
	{		
		[exchangeTableView setEditing:TRUE animated:YES];
		[editButton setTitle:@"Done"];
	}
}
//==========================================================================================
-(BOOL)loadNameCurrency
{
	BOOL result = FALSE;
	
	[namesCyrrency release];
	namesCyrrency = [[NSMutableArray alloc] init];
	
	TiXmlDocument domDocument;
	
	const char* messagesPath = [[[NSBundle mainBundle] pathForResource:@"nameCurrency" ofType:@"xml"] UTF8String];

	if( messagesPath && domDocument.LoadFile(messagesPath) )
	{
		TiXmlElement* rootNode = domDocument.RootElement();
		TiXmlElement* itemNode = rootNode->FirstChildElement("item");
		while(itemNode)
		{			
		  	const char* sName = itemNode->Attribute("abbreviation");
			const char* fName = itemNode->Attribute("full_name");
			if(sName && fName)
			{			
				NSString* shortName = [[[NSString alloc] initWithUTF8String: sName] autorelease];
				NSString* fullName = [[[NSString alloc] initWithUTF8String: fName] autorelease];
				MYExchangeNameCyrrency* nameCyrrency = [MYExchangeNameCyrrency newNameCurrencyWithTitle:shortName fullName:fullName]; 
				[namesCyrrency addObject: nameCyrrency];
			}
			itemNode = itemNode->NextSiblingElement("item");
		}
	}
	return result;
}
//==========================================================================================
-(BOOL)loadDataCyrrency
{
	BOOL result = FALSE;
	dataCyrrency = [[NSMutableArray alloc] init];
	//...
	return result;
}
//==========================================================================================
@end