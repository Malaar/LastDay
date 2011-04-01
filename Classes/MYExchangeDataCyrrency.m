//
//  MYExchangeDataCyrrency.h.m
//  LastDay
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYExchangeDataCyrrency.h"


@implementation MYExchangeDataCyrrency

//==========================================================================================
@synthesize nameFirstCurrency,nameSecondCurrency,indexFirstCurrency,indexSecondCurrency,course;
//==========================================================================================
+(id)cyrrency
{
	return [[[MYExchangeDataCyrrency alloc] init] autorelease];
}
//==========================================================================================
+(id)cyrrencyWithData:(NSString *)aCourse 
		   firstCurrency:(NSString *)aFirstCurrency 
		  secondCurrency:(NSString *)aSecondCurrency
{
	return [[[MYExchangeDataCyrrency alloc] initWithData:aCourse 
										   firstCurrency:aFirstCurrency 
										  secondCurrency:aSecondCurrency] autorelease];
}
//==========================================================================================
-(id)init
{
	return [self initWithData:nil firstCurrency:nil secondCurrency:nil];
}
//==========================================================================================
-(id)initWithData:(NSString*)aCourse firstCurrency:(NSString *)aFirstCurrency secondCurrency:(NSString *)aSecondCurrency
{
	if (self = [super init])
	{
		self.course = aCourse;
		self.nameFirstCurrency = aFirstCurrency;
		self.nameSecondCurrency = aSecondCurrency;
	}
	return self;
}
//==========================================================================================
- (id)   initWithData: (const char*)aCourse 
		firstCurrency: (const char*)aFirstCurrency 
	   secondCurrency: (const char*)aSecondCurrency
   indexFirstCurrency: (int) aIndexFirstCurrency
  indexSecondCurrency: (int) aIndexSecondCurrency
{
	if (self = [super init])
	{
		self.course = [NSString stringWithUTF8String:aCourse];
		self.nameFirstCurrency = [NSString stringWithUTF8String:aFirstCurrency];
		self.nameSecondCurrency = [NSString stringWithUTF8String:aSecondCurrency];
		self.indexFirstCurrency = aIndexFirstCurrency;
		self.indexSecondCurrency = aIndexSecondCurrency;
	}
	return self;
}
//==========================================================================================
-(NSString*)fullInfo
{
 	return [NSString stringWithFormat: @"1 %@ = %@ %@", 
			[self nameFirstCurrency],
			[self course], 
			[self nameSecondCurrency] ];
}
//==========================================================================================
- (void) dealloc
{
	[nameFirstCurrency release];
	[nameSecondCurrency release];
	[course release];
	[super dealloc];
}
//==========================================================================================
@end
