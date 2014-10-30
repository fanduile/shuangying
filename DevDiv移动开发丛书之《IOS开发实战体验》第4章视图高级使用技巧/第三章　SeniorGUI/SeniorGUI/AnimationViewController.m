//
//  AnimationViewController.m
//  SeniorGUI
//
//  Created by Chendy on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AnimationViewController.h"

@implementation AnimationViewController
@synthesize firstView;
@synthesize sndView;
@synthesize thirdView;
@synthesize fourthView;
@synthesize bgView;

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
    CGRect scrollFrame = CGRectMake(0, 0, 320, 360);
    bgView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    bgView.frame = scrollFrame;
    bgView.contentSize = CGSizeMake(320 * 4, 320);
    bgView.backgroundColor = [UIColor grayColor];
    
    CGRect viewFrame = CGRectMake(10, 10, 300, 300);
    firstView = [[UIView alloc]initWithFrame:viewFrame];
    firstView.backgroundColor = [UIColor orangeColor];
    viewFrame.origin.x += 320;
    sndView = [[UIView alloc] initWithFrame:viewFrame];
    sndView.backgroundColor = [UIColor orangeColor];
    viewFrame.origin.x += 320;
    thirdView = [[UIView alloc] initWithFrame:viewFrame];
    thirdView.backgroundColor = [UIColor orangeColor];
    viewFrame.origin.x += 320;
    fourthView = [[UIView alloc] initWithFrame:viewFrame];
    fourthView.backgroundColor = [UIColor orangeColor];
    
    [bgView addSubview:firstView];
    [bgView addSubview:sndView];
    [bgView addSubview:thirdView];
    [bgView addSubview:fourthView];
    bgView.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:245.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    bgView.pagingEnabled = YES;
    [self.view addSubview:bgView];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)animationControl:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:firstView cache:YES];
	int num = 60;
    if(isAni)
    {
        num = -num;
    }
    CGRect frame = firstView.frame;
    frame.origin.x += num;
    frame.origin.y += num;
    frame.size.width -= 2 * num;
    frame.size.height -= 2 * num;
    firstView.frame = frame;//动画执行的最终结果
    [UIView commitAnimations];
    isAni = !isAni;
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
