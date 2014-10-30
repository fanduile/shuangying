//
//  CategoryViewController.m
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import "CategoryViewController.h"
#import "CalRectangle.h"
#import "RTString.h"
#import "RTDictionary.h"
#import "RTArray.h"

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    int i = 3;
    id j = i;
    int k = j;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)testBaseCategory:(id)sender
{
    RTRectangle* rec = [[RTRectangle alloc] init];
    rec.width = 20;
    rec.height = 30;
    double area = [rec calculateArea];
    double length = [rec calculatePerimeter];
    NSString* areaStr = [NSString stringWithFormat:@"%f", area];
    NSString* lengthStr = [NSString stringWithFormat:@"%f", length];
    NSLog(@"Area = %@", areaStr);
    NSLog(@"Length = %@", lengthStr);
}

-(IBAction)testStringAlert:(id)sender
{
    NSString* alertString = @"通过Category弹出";
    [alertString alert];
}

-(IBAction)testStringSMS:(id)sender
{
    NSString* phoneNum = @"186-0123-0123";
    [phoneNum sendSMS];
}

-(IBAction)testStringTel:(id)sender
{
    NSString* phoneNum = @"186-0123-0123";
    [phoneNum makeCall];
}

-(IBAction)testStringEmail:(id)sender
{
    NSString* phoneNum = @"186-0123-0123";
    [phoneNum sendEmail];
}

-(IBAction)testArrayCategory:(id)sender
{
    NSArray* array = [[NSArray alloc] initWithObjects:@"Array1", @"Array2", @"Array3", @"Array4", nil];
    [array writeToPlistFile:@"array.plist"];
}

-(IBAction)testDictionaryCategory:(id)sender
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"object1",@"key1", @"object2", @"key2", @"object3", @"key3", @"object4",@"key4", nil];
    [dic writeToPlistFile:@"dictionary.plist"];
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
