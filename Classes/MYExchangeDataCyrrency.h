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
	NSInteger indexFirstCurrency;
	NSInteger indexSecondCurrency;
	NSString* course;
}

@property (nonatomic, retain) NSString* nameFirstCurrency;
@property (nonatomic, retain) NSString* nameSecondCurrency;
@property (nonatomic, assign) NSInteger indexFirstCurrency;
@property (nonatomic, assign) NSInteger indexSecondCurrency;
@property (nonatomic, retain) NSString* course;

+(id)cyrrency;
+(id)cyrrencyWithData: (NSString*)aCourse firstCurrency:(NSString*)aFirstCurrency secondCurrency: (NSString*)aSecondCurrency;

- (id)init;
- (id)initWithData: (NSString*)aCourse 
	 firstCurrency: (NSString*)aFirstCurrency 
	secondCurrency: (NSString*)aSecondCurrency;
- (id)   initWithData: (const char*)aCourse 
		firstCurrency: (const char*)aFirstCurrency 
	   secondCurrency: (const char*)aSecondCurrency
   indexFirstCurrency: (int) aIndexFirstCurrency
  indexSecondCurrency: (int) aIndexSecondCurrency;
- (NSString*)fullInfo;
@end
