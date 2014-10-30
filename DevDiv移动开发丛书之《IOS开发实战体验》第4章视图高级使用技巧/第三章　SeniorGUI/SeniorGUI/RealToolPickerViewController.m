//
//  RealToolPickerViewController.m
//  RealToolPicker
//
//  Created by chen dy on 11-6-1.
//  Copyright 2011年 dream. All rights reserved.
//

#import "RealToolPickerViewController.h"

@implementation RealToolPickerViewController

@synthesize pickerSheet;
@synthesize picker;
@synthesize isPickerShow;
@synthesize sourceArray;




- (void)dealloc
{
    [sourceArray release];
    picker = nil;
    pickerSheet = nil;
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array2 = [[NSArray alloc]initWithObjects: @"iOS应用软件开发", @"iOS企业OA开发",@"iOS定制应用", @"iOS游戏开发", nil];
    [self setSourceArray:array2];
	[array2 release];
    CGRect frame = CGRectMake(0, 480, 320, 320);
	pickerSheet = [[UIActionSheet alloc] initWithFrame:frame];
	CGRect btnFrame = CGRectMake(10, 5, 60, 30);
	UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cancelButton awakeFromNib];
	[cancelButton addTarget:self action:@selector(pickerHideCancel) forControlEvents:UIControlEventTouchUpInside];
	[cancelButton setFrame:btnFrame];
	cancelButton.backgroundColor = [UIColor clearColor];
	[cancelButton setTitle:@"取消" forState:UIControlStateNormal];
	[pickerSheet addSubview:cancelButton];
	
	CGRect btnOKFrame = CGRectMake(250, 5, 60, 30);
	UIButton* okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[okButton awakeFromNib];
	[okButton addTarget:self action:@selector(pickerHideOK) forControlEvents:UIControlEventTouchUpInside];
	[okButton setFrame:btnOKFrame];
	okButton.backgroundColor = [UIColor clearColor];
	[okButton setTitle:@"完成" forState:UIControlStateNormal];
	[pickerSheet addSubview:okButton];
	
	
	CGRect pickerFrame = CGRectMake(0, 40, 320, 216
                                    );	
	picker=[ [UIPickerView alloc] initWithFrame:pickerFrame]; 
	picker.autoresizingMask=UIViewAutoresizingFlexibleWidth;
	picker.showsSelectionIndicator = YES; 
	picker.delegate=self; 
	picker.dataSource=self;
	picker.tag = 101; 
	picker.hidden = NO;
	[pickerSheet addSubview:picker];
	[self.view addSubview:pickerSheet];
}

-(IBAction)realToolPickerTest
{
    [self pickerShow];
}

-(void)pickerShow
{
	if(!isPickerShow)
	{
		CGRect pickFrame = pickerSheet.frame;	
		[UIView beginAnimations:nil context:self];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];	
		pickFrame.origin.y -= pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];	
		[UIView commitAnimations];	
		isPickerShow = TRUE;
	}
}


-(void)pickerHideOK
{
	if(isPickerShow)//首先要隐藏，然后发送网络请求
	{
		CGRect pickFrame = pickerSheet.frame;	
		[UIView beginAnimations:nil context:self];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];	
		pickFrame.origin.y += pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];	
		[UIView commitAnimations];	
		isPickerShow = FALSE;
	}
}

-(void)pickerHideCancel
{
	if(isPickerShow)
	{
		CGRect pickFrame = pickerSheet.frame;	
		[UIView beginAnimations:nil context:self];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];	
		pickFrame.origin.y += pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];	
		[UIView commitAnimations];	
		isPickerShow = FALSE;
	}	
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [self.sourceArray objectAtIndex:row];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.sourceArray count];;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
