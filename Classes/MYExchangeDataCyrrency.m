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
@synthesize nameFirstCurrency, nameSecondCurrency, course;
//==========================================================================================
+(id)newCyrrency
{
	return [[[MYExchangeDataCyrrency alloc] init] autorelease];
}
//==========================================================================================
+(id)newCyrrencyWithData:(float)aCourse 
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
	return [self initWithData:0 firstCurrency:nil secondCurrency:nil];
}
//==========================================================================================
-(id)initWithData:(float)aCourse firstCurrency:(NSString *)aFirstCurrency secondCurrency:(NSString *)aSecondCurrency
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
-(NSString*)fullInfo
{
 	return [NSString stringWithFormat: @"%@ / %@ = %f", 
			[self nameFirstCurrency], 
			[self nameSecondCurrency], 
			[self course] ];
}
//==========================================================================================
@end
