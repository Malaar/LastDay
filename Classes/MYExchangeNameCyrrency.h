//
//  MYExchangeCyrrency.h
//  LastDay
//
//  Created by Student on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYExchangeNameCyrrency : NSObject 
{
	NSString *shortName;
	NSString *fullName;
}
@property (nonatomic, retain) NSString* shortName;
@property (nonatomic, retain) NSString* fullName;

+(id)newNameCurrency;
+(id)newNameCurrencyWithTitle:(NSString*) aShortName fullName:(NSString*) aFullName;

-(id)init;
-(id)initWithTitle: (NSString*) aShortName fullName: (NSString*) aFullName;
@end
