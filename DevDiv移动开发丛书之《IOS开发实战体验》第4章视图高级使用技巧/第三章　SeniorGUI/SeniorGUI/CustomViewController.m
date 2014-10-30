//
//  CustomViewController.m
//  SeniorGUI
//
//  Created by Chendy on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomViewController.h"
#import "RealToolPickerViewController.h"
#import "AnimationViewController.h"

@implementation CustomViewController
@synthesize pickerView;
@synthesize sourceArray;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array2 = [[NSArray alloc]initWithObjects: @"iOS应用软件开发", @"iOS企业OA开发",@"iOS定制应用", @"iOS游戏开发", nil];
    [self setSourceArray:array2];
	[array2 release];
    CGRect pickerFrame = CGRectMake(0, 460, 320, 216);	
    pickerView.frame = pickerFrame;
    pickerView.showsSelectionIndicator = YES;
    pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:pickerView];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [self.sourceArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 200;
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

-(IBAction)openCustomPickerView:(id)sender
{
    RealToolPickerViewController* realVC = [[RealToolPickerViewController alloc] init];
    [self presentModalViewController:realVC animated:YES];
    [realVC release];
}

-(IBAction)openAnimation:(id)sender
{
    AnimationViewController* aniVC = [[AnimationViewController alloc] init];
    [self presentModalViewController:aniVC animated:YES];
    [aniVC release];
}

-(IBAction)searchButtonClick:(id)sender
{
    CGRect pickFrame = pickerView.frame;	
    [UIView beginAnimations:nil context:self];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerView superview] cache:YES];	
    pickFrame.origin.y -= pickFrame.size.height;//应该根据应用动态计算需要的位置
    [pickerView setFrame:pickFrame];	
    [UIView commitAnimations];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
