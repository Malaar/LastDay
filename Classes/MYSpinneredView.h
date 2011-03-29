//
//  MYSpinnered.h
//  LastDay
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Spinnered oveley to indicate some process
@interface MYSpinneredView : UIView
{
	UIView* parentView;							///< parent view
	UIActivityIndicatorView* spinner;			///< spinner
}

- (id) initWithParentView: (UIView*)aParentView;
- (void) show;									///< show overlay and start spinner
- (void) hide;									///< hide overlay and stop spinner

@end
