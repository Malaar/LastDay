//
//  MYNewsRSSFeed.h
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Info about RSS feed - to take from json
@interface MYNewsRSSFeed : NSObject
{
	NSString* title;
	NSURL* url;
}

+ (id) newsRSSFeed;
+ (id) newsRSSFeedWithTitle: (NSString*)aTitle urlString: (NSString*)aUrlString;
- (id) init;
- (id) initWithTitle: (NSString*)aTitle urlString: (NSString*)aUrlString;

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSURL* url;

@end
