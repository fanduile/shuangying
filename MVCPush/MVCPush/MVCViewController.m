//
//  MVCViewController.m
//  MVCPush
//
//  Created by Chendy on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MVCViewController.h"
#import "MyUIViewController.h"

@implementation MVCViewController

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
    self.title = @"MVC演示";
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)mvcDemo1:(id)sender
{
    MyUIViewController* vc = [[MyUIViewController alloc] initWithNibName:@"MyUIViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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
