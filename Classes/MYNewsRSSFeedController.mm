//
//  MYNewsRSSFeedController.m
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYNewsRSSFeedController.h"
#import "MYNewsRSSItem.h"
#include "tinyxml.h"

@implementation MYNewsRSSFeedController

@synthesize rssFeed;

//==========================================================================================
- (void) setRssFeed:(MYNewsRSSFeed*) aNewsRssFeed
{
	if(rssFeed != aNewsRssFeed)
	{
		[rssFeed release];
		[aNewsRssFeed retain];
		rssFeed = aNewsRssFeed;
		
		[self.tabBarItem setTitle: aNewsRssFeed.title];
	}
}

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		//[self loadRssFeed];
		// ...
	}
	return self;
}

//==========================================================================================
- (void) viewWillAppear: (BOOL)animated
{
	[super viewWillAppear:animated];
	if(!news)
		[self loadRssFeed];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [news count];
}

//==========================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellID = @"newsCellID";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if(!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	}
	
	cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
	
	if([indexPath row] < [news count])
	{
		MYNewsRSSItem* rssItem = [news objectAtIndex:[indexPath row]];
		[cell.textLabel setText: rssItem.title];
		[cell.detailTextLabel setText: rssItem.pubDate];
	}

	return cell;
}

//==========================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!detailedController)
	{
		detailedController = [[MYNewsRSSDetailedController alloc] init];
	}
	
	detailedController.rssItem = [news objectAtIndex: [indexPath row]];
	[self.navigationController pushViewController:detailedController animated:YES];
	
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
	[rssFeed release];
	[news release];
	[receivedData release];
	[rssConnection cancel];
	[rssConnection release];
	[detailedController release];
	
    [super dealloc];
}

//==========================================================================================
- (void) loadRssFeed
{
	// prepare
	if(news)
		[news release];
	news = [[NSMutableArray alloc] init];
	[receivedData release];
	receivedData = [NSMutableData new];
	
	if(rssConnection)
	{
		[rssConnection cancel];
		[rssConnection release];
	}
	
	// make connection and request
	NSURLRequest* request = [[NSURLRequest alloc] initWithURL:rssFeed.url
												  cachePolicy:NSURLRequestReloadIgnoringCacheData
											  timeoutInterval:30];
	rssConnection = [[NSURLConnection alloc] initWithRequest:request
																	 delegate:self
															 startImmediately:YES];
	[request release];
}

//==========================================================================================
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}

//==========================================================================================
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
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
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString* xmlData = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
	xmlData = [xmlData stringByReplacingOccurrencesOfString:@"media:thumbnail" withString:@"media"];
	const char* receivedXMLString = [xmlData UTF8String];
	TiXmlDocument domDocument;
	domDocument.Parse(receivedXMLString);
	TiXmlElement* rootNode = domDocument.RootElement();
	TiXmlElement* channelNode = rootNode->FirstChildElement("channel");
	TiXmlElement* itemNode = channelNode->FirstChildElement("item");
	while(itemNode)
	{
		MYNewsRSSItem* rssItem = [MYNewsRSSItem newsRSSItem];
		
		const char* cStr = itemNode->FirstChildElement("title")->GetText();
		rssItem.title = [NSString stringWithUTF8String: cStr];
		
		cStr = itemNode->FirstChildElement("description")->GetText();
		rssItem.description = [NSString stringWithUTF8String: cStr];
		
		cStr = itemNode->FirstChildElement("link")->GetText();
		rssItem.link = [NSString stringWithUTF8String: cStr];
		
		cStr = itemNode->FirstChildElement("guid")->GetText();
		rssItem.guid = [NSString stringWithUTF8String: cStr];

		cStr = itemNode->FirstChildElement("pubDate")->GetText();
		rssItem.pubDate = [NSString stringWithUTF8String: cStr];
		
		// without image :(
		//TiXmlElement* mediaNode = itemNode->FirstChildElement("media");
		//const char* imageURL = mediaNode->Attribute("url");
		//TiXmlElement* mediaNode = itemNode->FirstChildElement("thumbnail");
		
		[news addObject:rssItem];
		
		itemNode = itemNode->NextSiblingElement("item");
	}
	
	[self.tableView reloadData];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
