//
//  MyUIViewController.m
//  MVCPush
//
//  Created by Chendy on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyUIViewController.h"
#import "MyUIView.h"

@implementation MyUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
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
    self.title = @"MVC演示一";
    CGRect frame = CGRectMake(0, 320, 320, 100);
    MyUIView* view = [[MyUIView alloc] initWithFrame:frame];
    view.delegate = self;
    [self.view addSubview:view];
    [view release];
    // Do any additional setup after loading the view from its nib.
}

- (void)func1
{
    NSLog(@"MyUIViewController MyUIView touchEnded!");
    self.view.backgroundColor = [UIColor blueColor];
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
