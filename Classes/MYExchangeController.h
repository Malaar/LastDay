//
//  MYExchangeController.h
//  LastDay
//
//  Created by yuriy on 25.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYExchangeChooseCurrencyController.h"
#import "MYSpinneredView.h"

@interface MYExchangeController : UIViewController 
								<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UIToolbar* toolBar;
	IBOutlet UITableView* exchangeTableView;
	
	MYSpinneredView* spinneredView;
	MYExchangeChooseCurrencyController* chooseCurrencyController;	
	
	UIBarButtonItem* editButton;
	
	NSMutableArray* namesCyrrency;
	NSMutableArray* dataCyrrency;
	
	NSString* lastDataUpdata;
	NSInteger indexSelecteCell;
	NSInteger indexLoadDataCyrrency;
	
	NSURLConnection* rssConnection;
	NSMutableData* receivedData;
}

@property (nonatomic, retain, readonly) NSMutableArray* namesCyrrency;

- (void) actionAddDataCyrrency;
- (void) actionCorrectDataCyrrency;
- (void) editExchangeTableView;
- (MYExchangeChooseCurrencyController*) chooseCurrencyController;
- (BOOL) loadNameCurrency;
- (BOOL) loadDataCyrrency;
- (void) loadRssFeed;
- (void) updataRssCyrrency: (MYExchangeDataCyrrency*) aDataCyrrency;
@end
