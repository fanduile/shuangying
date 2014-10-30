//
//  NotificationViewController.m
//  MVCPush
//
//  Created by Chendy on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NotificationViewController.h"

@implementation NotificationViewController
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiChangeBackgroundColor:) name:BNRColorChangedNotification object:nil];
}

-(void)notiChangeBackgroundColor:(NSNotification*)notify
{
    NSLog(@"notiChangeBackgroundColor");
    NSDictionary* userInfo = notify.userInfo;
    NSLog(@"userInfo description = %@", [userInfo description]);
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(IBAction)sendNotification:(id)sender
{
    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:BNRColorChangedNotification object:nil userInfo:userInfo];
}

//- (void)dealloc
//{
//    UIButton
////    NSNotificationCenter*nc = [NSNotificationCenter defaultCenter];
////    [nc removeObserver:self];
////    [super dealloc];
//}

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
