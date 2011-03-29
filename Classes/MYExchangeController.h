//
//  MYExchangeController.h
//  LastDay
//
//  Created by yuriy on 25.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYExchangeChooseCurrencyController.h"

@interface MYExchangeController : UIViewController 
								<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UIToolbar* toolBar;
	IBOutlet UITableView* exchangeTableView;
	MYExchangeChooseCurrencyController* chooseCurrencyController;
	UIBarButtonItem* editButton;
	
	NSMutableArray* namesCyrrency;
	NSMutableArray* dataCyrrency;
	
	NSString* lastDataUpdata;
}

@property (nonatomic, retain, readonly) NSMutableArray* namesCyrrency;

- (void) actionAddDataCyrrency;
- (void) actionCorrectDataCyrrency;
- (void) editExchangeTableView;
- (MYExchangeChooseCurrencyController*) chooseCurrencyController;
- (BOOL)loadNameCurrency;
- (BOOL)loadDataCyrrency;
@end
