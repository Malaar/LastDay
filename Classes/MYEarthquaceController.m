    //
//  MYEarthquaceController.m
//  LastDay
//
//  Created by yuriy on 30.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYEarthquaceController.h"


@implementation MYEarthquaceController

//==========================================================================================
- (id) init
{
	if(self = [super init])
	{
		// navigation item
		[self setTitle:@"Earthquace"];
		
		// map
		CGRect frame = [UIScreen mainScreen].bounds;
		mapViewEarth = [[MKMapView alloc] initWithFrame:frame];
		[mapViewEarth setDelegate:self];
		mapViewEarth.mapType = MKMapTypeHybrid;
		mapViewEarth.showsUserLocation = YES;
		[self.view addSubview:mapViewEarth];
	}
	return self;
}

//==========================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//==========================================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self loadEarthquaceRSS];
}

//==========================================================================================
- (void) viewDidDisappear:(BOOL)animated
{
	[rssConnection cancel];
}

//==========================================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
}


//==========================================================================================
- (void)dealloc
{
	[mapViewEarth release];
	[rssConnection cancel];
	[rssConnection release];
	[receivedData release];
	[earthquaces release];
    [super dealloc];
}

//==========================================================================================
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	//return nil;
	static NSString* annotationViewID = @"earthquaceAnnotationID";
	
	if([annotation isKindOfClass:[MKUserLocation class]])
	{
		return nil;
	}
	
	MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
	if(!annotationView)
	{
		annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
	}
	
	annotationView.image = [UIImage imageNamed:@"earthquace_center.png"];
	annotationView.canShowCallout = YES;
	
	return annotationView;
}

//==========================================================================================
- (void) loadEarthquaceRSS
{
	if(rssConnection)
	{
		[rssConnection cancel];
		[rssConnection release];
	}
	
	[mapViewEarth removeAnnotations:earthquaces];
	[earthquaces release];
	earthquaces = [[NSMutableArray alloc] init];
	[receivedData release];
	receivedData = [NSMutableData new];
	
	currEQAnnotation = nil;
	parseElement = parseOther;
	subjectElementIndex = -1;

	
	NSURL* rssURL = [[NSURL alloc] initWithString:@"http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M5.xml"];
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
	NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:receivedData];
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:YES];
	[xmlParser parse];
	[xmlParser release];
	for(id<MKAnnotation> ann in earthquaces)
	{
		[mapViewEarth addAnnotation:ann];
	}
}

//==========================================================================================
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqual:@"item"])
	{
		currEQAnnotation = [[MYEarthquaceAnnotation alloc] init];
		[earthquaces addObject:currEQAnnotation];
		[currEQAnnotation release];
		subjectElementIndex = -1;
	}
	
	if([elementName isEqual:@"title"])
		parseElement = parseTitle;
	else if([elementName isEqual:@"lat"])
		parseElement = parseLatitude;
	else if([elementName isEqual:@"long"])
		parseElement = parseLongitude;
	else if([elementName isEqual:@"subject"])
		parseElement = parseSubject;
	else
		parseElement = parseOther;

	if(parseElement != parseOther)
	{
		curElementText = [NSMutableString new];
	}
}

//==========================================================================================
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//currEQAnnotation
	if(parseElement == parseTitle && currEQAnnotation)
	{
		NSRange start = [curElementText rangeOfString:@" "];
		NSRange end = [curElementText rangeOfString:@","];
		NSRange range;
		range.location = start.location + 1;
		range.length = end.location - range.location;
		currEQAnnotation.magnitude = [[curElementText substringWithRange:range] floatValue];
	}
	else if(parseElement == parseLatitude)
	{
		[currEQAnnotation setLatitude: [curElementText floatValue]];
	}
	else if(parseElement == parseLongitude)
	{
		[currEQAnnotation setLongitude: [curElementText floatValue]];
	}
	else if(parseElement == parseSubject)
	{
		if(++subjectElementIndex == 2)
		{
			currEQAnnotation.deep = [curElementText floatValue];
		}
	}

	if(parseElement != parseOther)
	{
		[curElementText release];
		curElementText = nil;
	}
}

//==========================================================================================
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[curElementText appendString:string];
}

//==========================================================================================
//- (void)parserDidEndDocument:(NSXMLParser *)parser
//{
//}

//==========================================================================================
//==========================================================================================
//==========================================================================================


@end
