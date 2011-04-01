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

@synthesize weather;

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
		
		//
		weatherView = [MYWeatherView weatherView];
		[self.view addSubview: weatherView];
		//[mapViewWeather addSubview: weatherView];
	
		//[self showWeatherInCurrLocation];
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
	[weather release];
	[weatherView release];
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
	
	[weather release];
	weather = [[MYWeather alloc] init];
	
	[receivedData release];
	receivedData = [NSMutableData new];
	
	CLLocationCoordinate2D coord = mapViewWeather.userLocation.coordinate;
	NSString* strURL = [NSString stringWithFormat:@"http://api.wunderground.com/auto/wui/geo/WXCurrentObXML/index.xml?query=%f,%f",
						50,25];
	
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
	NSLog(@"%@",xmlData);

	TiXmlElement* rootNode = domDocument.RootElement();
	TiXmlElement* itemNode = rootNode->FirstChildElement("display_location");

	TiXmlElement* node = itemNode->FirstChildElement("full");	
	weather.strLocation = [ NSString stringWithUTF8String: node->GetText()];
	
	node = itemNode->FirstChildElement("elevation");	
	weather.elevation =[[NSString stringWithUTF8String:node->GetText()]floatValue];
	
	itemNode = rootNode->FirstChildElement("temp_c");	
	weather.temperature = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];	
	
	itemNode = rootNode->FirstChildElement("relative_humidity");	
	weather.humidity = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];		
	
	itemNode = rootNode->FirstChildElement("wind_degrees");	
	weather.windDegrees = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];
	
	itemNode = rootNode->FirstChildElement("wind_mph");	
	weather.windSpeed = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];
	
	itemNode = rootNode->FirstChildElement("pressure_string");	
	weather.pressureIn = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];
	
	itemNode = rootNode->FirstChildElement("pressure_mb");	
	weather.pressureMB = [[NSString stringWithUTF8String:itemNode->GetText()] floatValue];
	
	itemNode = rootNode->FirstChildElement("wind_dir");
	weather.windDir = [NSString stringWithUTF8String:itemNode->GetText()];
	
	
	//image
	TiXmlElement* iconsNode = rootNode->FirstChildElement("icons");
	TiXmlElement* iconSetNode = iconsNode->FirstChildElement("icon_set");
	TiXmlElement* iconUrl = iconSetNode->FirstChildElement("icon_url");
	NSString* pathImage = [NSString stringWithUTF8String:iconUrl->GetText()];
	
	NSLog(@"%@",pathImage);
	
	weather.weatherImage = [[UIImage alloc] 
							initWithData:[NSData dataWithContentsOfURL:
										  [NSURL URLWithString:pathImage]]];
	
	[self showWeatherInCurrLocation];
	NSLog(@"%@",xmlData);
}

//==========================================================================================
- (void) showWeatherInCurrLocation
{
	//update weather view
//	MYWeather* testWeather = [MYWeather weather];
//	testWeather.strLocation = @"Test location";
//	testWeather.windDir = @"WWS";
//	[testWeather retain];
//	weatherView.weatherInfo = testWeather;
	
	weatherView.weatherInfo = weather;
	
	CLLocationCoordinate2D currentCoord;// = mapViewWeather.userLocation.coordinate;
	currentCoord.latitude = 50;
	currentCoord.longitude = 25;
	MKCoordinateRegion coordRegion = MKCoordinateRegionMakeWithDistance(currentCoord, 100000, 100000);
	[mapViewWeather setRegion:coordRegion animated:YES];
}


//==========================================================================================
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if([annotation isKindOfClass:[MKUserLocation class]])
	{
		//[self showWeatherInCurrLocation];
	}
	
	return nil;	// default annotation view
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
