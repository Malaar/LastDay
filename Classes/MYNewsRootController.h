//
//  MYNewsController.h
//  LastDay
//
//  Created by Malaar on 16.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Root controller for news
@interface MYNewsRootController : UITabBarController
{

}

- (NSMutableArray*) getRSSFeeds; ///< load rss feeds from json

@end
