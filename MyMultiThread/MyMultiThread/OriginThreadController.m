//
//  OriginThreadController.m
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OriginThreadController.h"



void* threadLoop(void *param)
{
    while (true) 
    {
        OriginThreadController* vc = (OriginThreadController*)param;
        if(vc.isRun)
        {
            vc.labelIndex ++;
            int index = vc.labelIndex;
            NSString* str1 = vc.label.text;
            NSString* str2 = [NSString stringWithFormat:@"%@ %d", str1,index];
            vc.label.text = str2;
            NSLog(@"threadLoop Printed...%d", index);
            sleep(1);
        }
    }
}

@implementation OriginThreadController
@synthesize isRun = isRun_;
@synthesize label = label_;
@synthesize labelIndex = labelIndex_;

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
    self.title = @"线程演示";
    isRun_ = NO;
    labelIndex_  = 0;
    pthread_mutex_init( &mutext_, nil );
	int ret = pthread_create( &threadid_, nil,threadLoop, self );
}

-(IBAction)threadRun:(id)sender
{
    isRun_ = YES;
}
-(void)dealloc
{
    NSLog(@"销毁当前MVC,停止线程！");
    pthread_cancel(threadid_);
    pthread_mutex_destroy( &mutext_ );
    [super dealloc];
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
