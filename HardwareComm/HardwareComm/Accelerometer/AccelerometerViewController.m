//
//  AccelerometerViewController.m
//  HardwareComm
//
//  Created by Chendy on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AccelerometerViewController.h"

@implementation AccelerometerViewController
@synthesize xLabel = xLabel_;
@synthesize yLabel = yLabel_;
@synthesize zLabel = zLabel_;

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
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval =  0.1;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration 
{
    NSString* xStr = [NSString stringWithFormat:@"%f", acceleration.x];
    NSString* yStr = [NSString stringWithFormat:@"%f", acceleration.y];
    NSString* zStr = [NSString stringWithFormat:@"%f", acceleration.z];
    xLabel_.text = xStr;
    yLabel_.text = yStr;
    zLabel_.text = zStr;
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
