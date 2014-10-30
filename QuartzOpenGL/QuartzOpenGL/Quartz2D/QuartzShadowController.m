//
//  QuartzShadowController.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuartzShadowController.h"
#import "ShadowView.h"

@implementation QuartzShadowController

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
    self.title = @"Quartz阴影";
    CGRect frame = CGRectMake(0, 100, 320, 300);
    ShadowView* v = [[ShadowView alloc] initWithFrame:frame];
    [self.view addSubview:v];
    [v release];
    // Do any additional setup after loading the view from its nib.
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
