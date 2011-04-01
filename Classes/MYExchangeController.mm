    //
//  MYExchangeController.m
//  LastDay
//
//  Created by yuriy on 25.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYExchangeController.h"
#import "MYExchangeNameCyrrency.h"
#import "tinyxml.h"

@implementation MYExchangeController

//==========================================================================================
@synthesize namesCyrrency, lastDataUpdata;
//==========================================================================================
- (id) init
{
	if(self = [super initWithNibName:nil bundle:nil])
	{
		[self.navigationItem setTitle : @"Exchange rate"];		
		[self loadNameCurrency];
		[self loadDataCyrrency];
		
		NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self
							   selector:@selector(needSaveNotification:)
								   name:UIApplicationWillTerminateNotification
								 object:nil];
		[notificationCenter addObserver:self
							   selector:@selector(needSaveNotification:)
								   name:UIApplicationDidEnterBackgroundNotification
								 object:nil];
	}
	return self;
}
//==========================================================================================
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	spinneredView = [[MYSpinneredView alloc] initWithParentView:self.parentViewController.view];
	
	[labelLastDataUpdata setText: lastDataUpdata];
	
	[exchangeTableView setDelegate:self];
	[exchangeTableView setDataSource: self];
	
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:3];
	UIBarButtonItem* bbi;
	
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
														target:self
														action:@selector(loadRssFeed)] autorelease];
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
	
	BOOL updata = FALSE;
	NSMutableArray* newDataCurrency = [[self chooseCurrencyController] newCurrency];
	
	if ([newDataCurrency count] > 0) 
	{
		switch ([[self chooseCurrencyController] typeAction]) 
		{
			case actionAddNewCurrency:
				for (int i = 0; i < [newDataCurrency count]; i++) 
					[dataCyrrency addObject:[newDataCurrency objectAtIndex:i]];
				updata = TRUE;
				break;
			case actionCorrektCurrency:
				[dataCyrrency replaceObjectAtIndex:indexSelecteCell withObject: [newDataCurrency objectAtIndex:0]];
				updata = TRUE;
				break;
		}		
		if (updata)
		{
			[exchangeTableView reloadData];
			//[self loadRssFeed];
		}

	}
	[[self chooseCurrencyController] setTypeAction: actionNoTupe];
}
//==========================================================================================
- (void) viewDidUnload
{
	[super viewDidUnload];
	
	[toolBar release];
	toolBar = nil;	
	[exchangeTableView release];
	exchangeTableView = nil;
	[labelLastDataUpdata release];
	labelLastDataUpdata = nil;
}
//==========================================================================================
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	if(rssConnection)
	{
		[rssConnection cancel];
		[rssConnection release];
		rssConnection = nil;
	}
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
	[labelLastDataUpdata release];
	[editButton release];
	[namesCyrrency release];
	[dataCyrrency release];
	[lastDataUpdata release];
    [spinneredView release];
	[receivedData release];
	[rssConnection cancel];
	[rssConnection release];
	[super dealloc];
}
//==========================================================================================
-(void)actionAddDataCyrrency
{
	[[self chooseCurrencyController] setTypeAction: actionAddNewCurrency];
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
	[exchangeTableView deselectRowAtIndexPath:indexPath animated:YES];
	indexSelecteCell = [indexPath row];
	[[self chooseCurrencyController] setCorrectionDataCyrrency: [dataCyrrency objectAtIndex:[indexPath row]]];
	[self actionCorrectDataCyrrency];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[exchangeTableView deselectRowAtIndexPath:indexPath animated:TRUE];
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
				MYExchangeNameCyrrency* nameCyrrency = [MYExchangeNameCyrrency nameCurrencyWithTitle:shortName fullName:fullName]; 
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
	
	TiXmlDocument domDocument;
	if (lastDataUpdata) 
	{
		[lastDataUpdata release];
		lastDataUpdata = nil;
	}
	const char* messagesPath = 0;
	
	// try to load from Documents/ directory:
	NSString* strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	strPath = [strPath stringByAppendingPathComponent:@"dataCyrrency.xml"];
	
	if( [[NSFileManager defaultManager] fileExistsAtPath:strPath] )
	{
		messagesPath = [strPath UTF8String];
	}
	
	if( messagesPath && domDocument.LoadFile(messagesPath) )
	{
		TiXmlElement* rootNode = domDocument.RootElement();
		TiXmlElement* lastDataNode = rootNode->FirstChildElement("lastDate");
		if (lastDataNode) 
		{
			[self setLastDataUpdata:[NSString stringWithUTF8String:lastDataNode->GetText() ]];
			[labelLastDataUpdata setText:[self lastDataUpdata]];
		}		
		TiXmlElement* itemNode = rootNode->FirstChildElement("item");
		while(itemNode)
		{			
			const char* fnc = itemNode->Attribute("fnc");
			const char* snc = itemNode->Attribute("snc");
			const char* cours = itemNode->Attribute("course");
			int isnc = 0;
			itemNode->QueryIntAttribute("isnc",&isnc);
			int ifnc = 0;
			itemNode->QueryIntAttribute("ifnc",&ifnc);
			
			MYExchangeDataCyrrency* newCurrency = [[[MYExchangeDataCyrrency alloc] 
												   initWithData:cours
												   firstCurrency:fnc
												   secondCurrency:snc
												   indexFirstCurrency:ifnc
													indexSecondCurrency:isnc] autorelease];
			[dataCyrrency addObject:newCurrency];
			itemNode = itemNode->NextSiblingElement("item");
		}
	}
	return result;
}
//==========================================================================================
- (void) needSaveNotification: (NSNotification*) notification
{
	[self saveDataCyrrency];
}
//==========================================================================================
- (void) saveDataCyrrency
{
	if(!dataCyrrency || [dataCyrrency  count] == 0)
		return;
	
	TiXmlDocument domDocument;
	TiXmlElement* rootNode = new TiXmlElement("dataCyrrency");
	
	TiXmlElement* timeNode = new TiXmlElement("lastDate");
	TiXmlText* text = new TiXmlText( [[self lastDataUpdata] UTF8String] );
	timeNode->LinkEndChild(text);
	rootNode->LinkEndChild(timeNode);
	
	for(int i = 0; i < [dataCyrrency count]; ++i)
	{
		MYExchangeDataCyrrency* data = [dataCyrrency objectAtIndex: i];
		TiXmlElement* itemNode = new TiXmlElement("item");
		itemNode->SetAttribute("fnc", [[data nameFirstCurrency] UTF8String]);
		itemNode->SetAttribute("snc", [[data nameSecondCurrency] UTF8String]);
		itemNode->SetAttribute("ifnc", [data indexFirstCurrency]);
		itemNode->SetAttribute("isnc", [data indexSecondCurrency]);
		itemNode->SetAttribute("course", [[data course] UTF8String]);
		
		rootNode->LinkEndChild(itemNode);
	}
	domDocument.LinkEndChild(rootNode);
	
	// save into the Documents/ directory
	NSString* messagesPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	const char* strPath = [[messagesPath stringByAppendingPathComponent:@"dataCyrrency.xml"] UTF8String];
	domDocument.SaveFile(strPath);
}
//==========================================================================================
- (void) loadRssFeed
{	
	if ([dataCyrrency count]) 
	{
		indexLoadDataCyrrency = 0;
		[self updataRssCyrrency:[dataCyrrency objectAtIndex:indexLoadDataCyrrency] ];
		[spinneredView show];
		[exchangeTableView setScrollEnabled: false];
	}
}
//==========================================================================================
- (void) updataRssCyrrency: (MYExchangeDataCyrrency*) aDataCyrrency
{
	[receivedData release];
	receivedData = [NSMutableData new];
	
	if(rssConnection)
	{
		[rssConnection cancel];
		[rssConnection release];
	}
		
	NSString* strURL = [NSString stringWithFormat:@"http://themoneyconverter.com/%@/rss.xml",
						aDataCyrrency.nameFirstCurrency];
	NSURL* url = [NSURL URLWithString:strURL];
	NSURLRequest* request = [[[NSURLRequest alloc] initWithURL:url
												  cachePolicy:NSURLRequestReloadIgnoringCacheData
											  timeoutInterval:30] autorelease];
	rssConnection = [[NSURLConnection alloc] initWithRequest:request
													delegate:self
											startImmediately:YES];
}
//==========================================================================================
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString* xmlData = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
	const char* receivedXMLString = [xmlData UTF8String];
	TiXmlDocument domDocument;
	domDocument.Parse(receivedXMLString);
	TiXmlElement* rootNode = domDocument.RootElement();
	TiXmlElement* channelNode = rootNode->FirstChildElement("channel");	
	if (channelNode)
	{
		MYExchangeDataCyrrency * cyrrency = [dataCyrrency objectAtIndex:indexLoadDataCyrrency];
		if (cyrrency) 
		{
			NSString* key = [NSString stringWithFormat:@"%@/%@",cyrrency.nameSecondCurrency,cyrrency.nameFirstCurrency ];
			//date
			TiXmlElement* itemNode = channelNode->FirstChildElement("lastBuildDate");
			if (itemNode) {
				NSString* newDate = [NSString stringWithUTF8String:itemNode->GetText()];
				[self setLastDataUpdata:newDate];
				[labelLastDataUpdata setText:[self lastDataUpdata]];
			}		
			//item
			itemNode = channelNode->FirstChildElement("item");
			while(itemNode)
			{
				const char* cStr = itemNode->FirstChildElement("title")->GetText();
				NSString* itemKey = [NSString stringWithUTF8String: cStr];
				if ([key isEqualToString:itemKey]) 
				{
					const char* cStr = itemNode->FirstChildElement("description")->GetText();
					char* s = strstr(cStr, "= ");
					s = strchr(strchr( strchr(s,'='),' '),' ');
					s = strtok(s," ");
					[[dataCyrrency objectAtIndex:indexLoadDataCyrrency]	setCourse:[NSString stringWithUTF8String:s]];
					break;
				}
				itemNode = itemNode->NextSiblingElement("item");
			}
		}				
	}
	
	indexLoadDataCyrrency++;
	if (indexLoadDataCyrrency == [dataCyrrency count]) 
	{
		[spinneredView hide];
		[exchangeTableView reloadData];
		[exchangeTableView setScrollEnabled: true];
	}
	else 
	{
		[self updataRssCyrrency: [dataCyrrency objectAtIndex:indexLoadDataCyrrency]];
	}

}
//==========================================================================================
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	[spinneredView hide];
	[rssConnection release];
	rssConnection = nil;
	[receivedData release];
	receivedData = nil;
	UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:@"Connection Error"
														 message:[error localizedDescription]
														delegate:self
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil] autorelease];
	[alertView show];
}
//==========================================================================================
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{	
	[receivedData appendData:data];
}
//==========================================================================================
@end