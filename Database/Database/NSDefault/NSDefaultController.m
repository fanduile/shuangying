//
//  NSDefaultController.m
//  Database
//
//  Created by  on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDefaultController.h"

@interface NSDefaultController ()

@end

@implementation NSDefaultController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)setInfo:(id)sender
{
    NSUserDefaults* def =  [NSUserDefaults standardUserDefaults];
    NSLog(@"%@" , [def dictionaryRepresentation]);
    [def setInteger:10 forKey:@"test set Integer"];
    [def setBool:YES forKey:@"test set Bool"];
    NSLog(@"%@" , [def valueForKey:@"test set Integer"]);
    NSLog(@"%@" , [def valueForKey:@"test set Bool"]);
    NSLog(@"%@" , [def dictionaryRepresentation]);
}

-(IBAction)getInfo:(id)sender
{
    NSUserDefaults* def =  [NSUserDefaults standardUserDefaults];
    NSLog(@"%@" , [def dictionaryRepresentation]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
