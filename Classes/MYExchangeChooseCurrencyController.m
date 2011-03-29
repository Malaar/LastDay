//
//  MYExchangeChooseCurrencyController.m
//  LastDay
//
//  Created by yuriy on 27.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYExchangeChooseCurrencyController.h"
#import "MYExchangeNameCyrrency.h"
#import "MYExchangeDataCyrrency.h"

@implementation MYExchangeChooseCurrencyController

//==========================================================================================
@synthesize namesCurrency, newCurrency;
//==========================================================================================
-(id)init
{
	if (self = [super initWithNibName:nil bundle:nil])
	{
		[[self navigationItem] setTitle: @"Choose exchange"];
	}
	return self;
}
//==========================================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
	[labelTop setText:nil];
	[labelButton setText:nil];
	
	NSMutableArray* toolBarItems = [NSMutableArray arrayWithCapacity:3];
	UIBarButtonItem* bbi;
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: send message
	bbi = [[[UIBarButtonItem alloc] initWithTitle:@"   Ok   " style:UIBarButtonItemStyleBordered 
										   target:self
										   action:@selector(okButtonPressed)] autorelease];
	[toolBarItems addObject: bbi];
	okButton = bbi;
	[okButton setEnabled:FALSE];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	// item: cancel editing 
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
														 target:self
														 action:@selector(canselButtonPressed)] autorelease];
	[toolBarItems addObject: bbi];
	
	// item: space
	bbi = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:nil] autorelease];
	[toolBarItems addObject:bbi];
	
	[toolBar setItems:toolBarItems animated:YES];
	
}
//==========================================================================================
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
		
	MYExchangeNameCyrrency* nameCyrrency;
	
	NSInteger indexFirstComponent = [pickerView selectedRowInComponent:kFirstPickerComponent];
	if(indexFirstComponent >= 0 && indexFirstComponent < [namesCurrency count])
	{
		nameCyrrency = (MYExchangeNameCyrrency*)[namesCurrency objectAtIndex:indexFirstComponent];
		[labelTop setText: nameCyrrency.fullName ];
	}
	NSInteger indexSecondComponent = [pickerView selectedRowInComponent:kSecondPickerComponent];
	if(indexSecondComponent >= 0 && indexSecondComponent < [namesCurrency count])
	{
		nameCyrrency = (MYExchangeNameCyrrency*)[namesCurrency objectAtIndex:indexSecondComponent];
		[labelButton setText: nameCyrrency.fullName ];
	}
	if (okButton) {
		[okButton setEnabled: [self isDifferentIndexOfComponent]];
	}
	[labelCountCurrency setText:@""];
}
//==========================================================================================
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
//	if (okButton) 
//	{
//		[okButton setEnabled:FALSE];
//	}
}
//==========================================================================================
- (void)viewDidUnload 
{
    [super viewDidUnload];
	[pickerView release];
	pickerView = nil;
	
	[toolBar release];
	toolBar = nil;
	
	[labelTop release];
	labelTop = nil;
	
	[labelButton release];
	labelButton = nil;
	
	[labelCountCurrency release];
	labelCountCurrency = nil;
}
//==========================================================================================
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
//==========================================================================================
- (void)dealloc 
{
	[pickerView release];
	[toolBar release];
	[labelTop release];
	[labelButton release];
	[labelCountCurrency release];
	[namesCurrency release];
	[newCurrency release];
    [super dealloc];
}
//==========================================================================================
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [namesCurrency count];
}
//==========================================================================================
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}
//==========================================================================================
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
	MYExchangeNameCyrrency* nameCyrrency = [namesCurrency objectAtIndex:row];
	return nameCyrrency.shortName;
}
//==========================================================================================
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
	if (component == kFirstPickerComponent) 
	{
		MYExchangeNameCyrrency* nameCyrrency = (MYExchangeNameCyrrency*)[namesCurrency objectAtIndex:row];
		[labelTop setText: nameCyrrency.fullName ];
	}
	if (component == kSecondPickerComponent) 
	{
		MYExchangeNameCyrrency* nameCyrrency = (MYExchangeNameCyrrency*)[namesCurrency objectAtIndex:row];
		[labelButton setText: nameCyrrency.fullName ];		
	}
	if (okButton)
	{
		if (!newCurrency || [newCurrency count] != kMaxCoundAddCurrency)
			[okButton setEnabled:[self isDifferentIndexOfComponent]];			
	}
}
//==========================================================================================
-(void)setTypeAction:(MYExchangeChooseCurrencyControllerTypeAction)aTypeAction
{
	typeAction = aTypeAction;
	[newCurrency release];
	newCurrency = nil;
}
//==========================================================================================
-(void)okButtonPressed
{
	if (okButton && typeAction != actionNoTupe) 
	{
		if (!newCurrency)
			newCurrency = [[NSMutableArray alloc] init];

		MYExchangeDataCyrrency* dataCyrrency = [[MYExchangeDataCyrrency alloc] init];
		NSInteger ind_1 = [pickerView selectedRowInComponent:kFirstPickerComponent];
		NSInteger ind_2 = [pickerView selectedRowInComponent:kSecondPickerComponent];
		NSString* str_1 = [[namesCurrency objectAtIndex:ind_1] shortName];
		NSString* str_2 = [[namesCurrency objectAtIndex:ind_2] shortName];
		[dataCyrrency setNameFirstCurrency:str_1];
		[dataCyrrency setNameSecondCurrency:str_2];
		//[dataCyrrency setNameFirstCurrency: [namesCurrency objectAtIndex:[pickerView selectedRowInComponent:kFirstPickerComponent]]];
		//[dataCyrrency setNameSecondCurrency:[namesCurrency objectAtIndex:[pickerView selectedRowInComponent:kSecondPickerComponent]]];
		
		switch (typeAction) 
		{
			case actionAddNewCurrency:
				if ([newCurrency count] < kMaxCoundAddCurrency) 
				{
					[newCurrency addObject:dataCyrrency];
				}
				if ([newCurrency count] == kMaxCoundAddCurrency)
				{
					[okButton setEnabled:FALSE];
				}
				NSString* value = [NSString stringWithFormat:@"%@ | %@, ",dataCyrrency.nameFirstCurrency, dataCyrrency.nameSecondCurrency];
				NSString* name = [labelCountCurrency.text stringByAppendingString:value];
				
				[labelCountCurrency setText:name];
				break;
			case actionCorrektCurrency:
				[newCurrency addObject:dataCyrrency];
				[okButton setEnabled:FALSE];
				break;
		}
		[dataCyrrency release];		
	}
}
//==========================================================================================
-(void)canselButtonPressed
{
	//typeAction = actionNoTupe;
	[newCurrency release];
	newCurrency = nil;
	if(okButton)
		[okButton setEnabled:[self isDifferentIndexOfComponent]];
	[labelCountCurrency setText:@""];
}
//==========================================================================================
-(BOOL)isDifferentIndexOfComponent
{
	NSInteger indexFirstComponent = [pickerView selectedRowInComponent:kFirstPickerComponent];
	NSInteger indexSecondComponent = [pickerView selectedRowInComponent:kSecondPickerComponent];
	return (indexFirstComponent != indexSecondComponent);
}
//==========================================================================================
-(MYExchangeChooseCurrencyControllerTypeAction)typeAction
{
	return typeAction;
}
//==========================================================================================

//==========================================================================================

@end
