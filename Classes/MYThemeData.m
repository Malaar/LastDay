//
//  MYThemeData.m
//  LastDay
//
//  Created by Malaar on 15.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYThemeData.h"


@implementation MYThemeData

@synthesize title;
@synthesize image;

+ (id) themeDataWithTitle: (NSString*)aTitle image: (UIImage*) aImage;
{
	return [[[MYThemeData alloc] initWithTitle:aTitle image:aImage] autorelease];
}

- (id) initWithTitle: (NSString*)aTitle image: (UIImage*) aImage
{
	if(self = [super init])
	{
		self.title = aTitle;
		self.image = aImage;
	}
	return self;
}

- (void) dealloc
{
	[title release];
	[image release];
	[super dealloc];
}

@end
