//
//  MYExchangeChooseCurrencyController.h
//  LastDay
//
//  Created by yuriy on 27.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYExchangeDataCyrrency.h"

#define kFirstPickerComponent 0
#define kSecondPickerComponent 1
#define kMaxCoundAddCurrency 3

enum MYExchangeChooseCurrencyControllerTypeAction 
{
	actionNoTupe,
	actionAddNewCurrency,
	actionCorrektCurrency
};
typedef enum MYExchangeChooseCurrencyControllerTypeAction MYExchangeChooseCurrencyControllerTypeAction;

@interface MYExchangeChooseCurrencyController : UIViewController 
							<UIPickerViewDelegate, UIPickerViewDataSource>
{
	IBOutlet UIPickerView* pickerView;
	IBOutlet UIToolbar* toolBar;
	IBOutlet UILabel* labelTop;
	IBOutlet UILabel* labelButton;
	IBOutlet UILabel* labelCountCurrency;
	
	NSMutableArray* namesCurrency;
	NSMutableArray* newCurrency;
	
	UIBarButtonItem* okButton;
	UIBarButtonItem* cancelButton;
	
	MYExchangeDataCyrrency* correctionDataCyrrency;

	MYExchangeChooseCurrencyControllerTypeAction typeAction;
}

@property (nonatomic, retain) NSMutableArray* namesCurrency;
@property (nonatomic, retain) NSMutableArray* newCurrency;
@property (nonatomic, retain) MYExchangeDataCyrrency* correctionDataCyrrency;

-(void)okButtonPressed;
-(void)canselButtonPressed;
-(void)setTypeAction:(MYExchangeChooseCurrencyControllerTypeAction)aTypeAction;
-(MYExchangeChooseCurrencyControllerTypeAction)typeAction;
-(BOOL)isDifferentIndexOfComponent;

@end
