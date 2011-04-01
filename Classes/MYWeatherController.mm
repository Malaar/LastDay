    //
//  MYWeatherController.m
//  LastDay
//
//  Created by yuriy on 01.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYWeatherController.h"
#import "tinyxml.h"


@implementation MYWeatherController
//==========================================================================================
- (id)init
{
	if (self = [super init])
	{
		// navigation item
		[self setTitle:@"Weather"];
		
		// map
		CGRect frame = [UIScreen mainScreen].bounds;
		mapViewWeather = [[MKMapView alloc] initWithFrame:frame];
		[mapViewWeather setDelegate:self];
		mapViewWeather.mapType = MKMapTypeHybrid;
		mapViewWeather.showsUserLocation = YES;
		[self.view addSubview:mapViewWeather];
	}
	return self;
}
//==========================================================================================
- (void)viewDidLoad 
{
	[super viewDidLoad];
}
//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self loadWeatherRSS];
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
	[mapViewWeather release];
	[rssConnection cancel];
	[rssConnection release];
	[receivedData release];
    [super dealloc];
}
//==========================================================================================
- (void) loadWeatherRSS
{
	if(rssConnection)
	{
		[rssConnection cancel];
		[rssConnection release];
	}
	
	[receivedData release];
	receivedData = [NSMutableData new];
	
	CLLocationCoordinate2D coord = mapViewWeather.userLocation.coordinate;
	NSString* strURL = [NSString stringWithFormat:@"http://api.wunderground.com/auto/wui/geo/WXCurrentObXML/index.xml?query=%f,%f",
						coord.latitude,coord.longitude];
	
	NSURL* rssURL = [[NSURL alloc] initWithString: strURL];
	NSURLRequest* request = [[[NSURLRequest alloc] initWithURL:rssURL
												   cachePolicy:NSURLRequestReloadIgnoringCacheData
											   timeoutInterval:30] autorelease];
	rssConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
	[rssURL release];
}
//==========================================================================================
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}

//==========================================================================================
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	//[spinneredView hide];
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
	const char* receivedXMLString = [xmlData UTF8String];
	TiXmlDocument domDocument;
	domDocument.Parse(receivedXMLString);	
	NSLog(xmlData);
}
//==========================================================================================

@end
