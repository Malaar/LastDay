//
//  MYExchangeDataCyrrency.h
//  LastDay
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYExchangeDataCyrrency : NSObject 
{
	NSString* nameFirstCurrency;
	NSString* nameSecondCurrency;
	float course;
}

@property (nonatomic, retain) NSString* nameFirstCurrency;
@property (nonatomic, retain) NSString* nameSecondCurrency;
@property (nonatomic) float course;

+(id)newCyrrency;
+(id)newCyrrencyWithData: (float)aCourse firstCurrency:(NSString*)aFirstCurrency secondCurrency: (NSString*)aSecondCurrency;

- (id)init;
- (id)initWithData: (float)aCourse firstCurrency:(NSString*)aFirstCurrency secondCurrency: (NSString*)aSecondCurrency; 
- (NSString*)fullInfo;
@end
