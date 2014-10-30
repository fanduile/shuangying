//
//  CustomViewController.h
//  SeniorGUI
//
//  Created by Chendy on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController
{
    UIPickerView* pickerView;
    NSArray* sourceArray;
}
@property(nonatomic, retain) IBOutlet UIPickerView* pickerView;
@property(nonatomic, retain) NSArray* sourceArray;

-(IBAction)searchButtonClick:(id)sender;
-(IBAction)openCustomPickerView:(id)sender;
-(IBAction)openAnimation:(id)sender;

@end
