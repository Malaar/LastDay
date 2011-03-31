//
//  MYExchangeCyrrency.m
//  LastDay
//
//  Created by Student on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYExchangeNameCyrrency.h"


@implementation MYExchangeNameCyrrency

//==========================================================================================
@synthesize shortName, fullName;
//==========================================================================================
+(id)newNameCurrency
{
	return [[[MYExchangeNameCyrrency alloc] init] autorelease];
}
//==========================================================================================
+(id)newNameCurrencyWithTitle:(NSString *)aShortName 
					 fullName:(NSString *)aFullName
{
	return [[[MYExchangeNameCyrrency alloc] initWithTitle:aShortName 
												 fullName:aFullName] autorelease];
}
//==========================================================================================
-(id)init
{
	return [self initWithTitle:nil fullName:nil];
}
//==========================================================================================
-(id)initWithTitle:(NSString *)aShortName 
		  fullName:(NSString *)aFullName
{
	if (self = [super init])
	{
		self.shortName = aShortName;
		self.fullName = aFullName;
	}
	return self;
}
//==========================================================================================
- (void) dealloc
{
	[fullName release];
	[shortName release];
	[super dealloc];
}
//==========================================================================================
@end
