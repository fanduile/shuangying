//
//  QuartzGradientController.m
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuartzGradientController.h"
#import "GradientView.h"
@implementation QuartzGradientController
@synthesize gradientView = gradientView_;
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
    self.title = @"渐变演示";
    CGRect frame = CGRectMake(0, 100, 320, 300);
    GradientView* v = [[GradientView alloc] initWithFrame:frame];
    self.gradientView = v;
    v.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.gradientView];
    [v release];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)segmentChange:(id)sender
{
    UISegmentedControl* segment = (UISegmentedControl*)sender;
    int index = segment.selectedSegmentIndex;
    if(index == 0)
    {
        gradientView_.type = 0;
        [gradientView_ setNeedsDisplay];
    }
    else if(index == 1)
    {
        gradientView_.type = 1;
        [gradientView_ setNeedsDisplay];
    }
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
