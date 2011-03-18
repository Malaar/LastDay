//
//  MYNewsRSSItem.h
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Item of RSS feed
@interface MYNewsRSSItem : NSObject
{
	NSString* title;
	NSString* description;
	NSString* link;
	NSString* pubDate;
	NSString* guid;
	UIImage* image;
}

+ (id) newsRSSItem;
+ (id) newsRSSItemWithDictionary: (NSDictionary*)aDictionary;
- (id) init;
- (id) initWithDictionary: (NSDictionary*)aDictionary;

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* link;
@property (nonatomic, retain) NSString* pubDate;
@property (nonatomic, retain) NSString* guid;
@property (nonatomic, retain) UIImage* image;

@end
