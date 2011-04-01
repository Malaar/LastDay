//
//  MYNewsRSSDetailedController.h
//  LastDay
//
//  Created by Malaar on 17.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYNewsRSSItem.h"

@interface MYNewsRSSDetailedController : UIViewController
{
	MYNewsRSSItem* rssItem;
	IBOutlet UILabel* lbTitle;
	IBOutlet UITextView* textView;
}

@property (nonatomic, retain) MYNewsRSSItem* rssItem;

@end
