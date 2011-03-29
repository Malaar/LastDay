//
//  MYSpinnered.m
//  LastDay
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYSpinneredView.h"


@implementation MYSpinneredView

//==========================================================================================
- (id) initWithParentView: (UIView*)aParentView
{
	if((self = [super init]) && aParentView)
	{
		parentView = aParentView;
		// overlay
		self.frame = [UIScreen mainScreen].bounds;
		self.backgroundColor = [UIColor grayColor];
		self.alpha = 0.5;
		// spinner
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.center = self.center;
		[self addSubview:spinner];
	}
	return self;
}

//==========================================================================================
- (void) dealloc
{
	[self removeFromSuperview];
	[spinner release];
	
	[super dealloc];
}

//==========================================================================================
- (void) show
{
	[parentView addSubview:self];
	[spinner startAnimating];
}

//==========================================================================================
- (void) hide
{
	[spinner stopAnimating];
	[self removeFromSuperview];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================

@end
