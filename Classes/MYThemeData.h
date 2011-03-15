//
//  MYThemeData.h
//  LastDay
//
//  Created by Malaar on 15.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYThemeData : NSObject
{
@private
	NSString* title;
	UIImage* image;
}

+ (id) themeDataWithTitle: (NSString*)aTitle image: (UIImage*) aImage;
- (id) initWithTitle: (NSString*)aTitle image: (UIImage*) aImage;

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIImage* image;

@end
