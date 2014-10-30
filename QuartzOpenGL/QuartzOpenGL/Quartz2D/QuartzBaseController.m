//
//  QuartzBaseController.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuartzBaseController.h"
#import "CanvasView.h"

@implementation QuartzBaseController
@synthesize segment = segment_;
@synthesize canvasView = canvasView_;
@synthesize slider = slider_;

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
    self.title = @"Quartz演示";
    CGRect frame = CGRectMake(0, 100, 320, 300);
    CanvasView* canvas = [[CanvasView alloc] initWithFrame:frame];
    canvas.backgroundColor = [UIColor clearColor];
    self.canvasView = canvas;
    [canvas release];
    [segment_ setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [self.view addSubview:self.canvasView];
}

-(IBAction)slideChange:(id)sender
{
    UISlider* sli = (UISlider*)sender;
    CGFloat value = sli.value;
    canvasView_.phase = value;
    [canvasView_ setNeedsDisplay];
}

-(IBAction)selectButton:(int)sender
{
    UISegmentedControl *mySegment=(UISegmentedControl *)sender;
    switch (mySegment.selectedSegmentIndex) 
    {
        case 0:
        {
            canvasView_.type = 0;
            [canvasView_ setNeedsDisplay];
            break;
        }
        case 1:
        {
            canvasView_.type = 1;
            [canvasView_ setNeedsDisplay];
            break;
        }
        case 2:
        {
            canvasView_.type = 2;
            [canvasView_ setNeedsDisplay];
            break;
        }
        case 3:
        {
            canvasView_.type = 3;
            [canvasView_ setNeedsDisplay];
            break;
        }
        case 4:
        {
            canvasView_.type = 4;
            [canvasView_ setNeedsDisplay];
            break;
        }
        default:
            break;
    }
}

-(IBAction)drawDashLine:(id)sender
{
    canvasView_.type = 4;
    [canvasView_ setNeedsDisplay];
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

-(void)dealloc
{
    [super release];
}

@end
