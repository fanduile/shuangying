//
//  RealToolPickerViewController.h
//  RealToolPicker
//
//  Created by chen dy on 11-6-1.
//  Copyright 2011年 dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealToolPickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> 
{
    UIActionSheet* pickerSheet;
	bool isPickerShow;
	UIPickerView* picker;
    NSArray* sourceArray;
}

@property(nonatomic, retain)UIActionSheet* pickerSheet;
@property(nonatomic, retain)UIPickerView* picker;
@property(nonatomic)bool isPickerShow;
@property(nonatomic, retain) NSArray* sourceArray;

-(IBAction)realToolPickerTest;

-(void)pickerShow;
-(void)pickerHideOK;
-(void)pickerHideCancel;

@end
