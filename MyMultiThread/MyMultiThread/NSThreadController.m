//
//  NSThreadController.m
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSThreadController.h"

@implementation NSThreadController

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
    tickets = 100;
    count = 0;
    // 锁对象
    ticketsCondition = [[NSCondition alloc] init];
    ticketsThreadone = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadone setName:@"Thread-1"];
    [ticketsThreadone start];
    
    ticketsThreadtwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadtwo setName:@"Thread-2"];
    [ticketsThreadtwo start];
    
    ticketsThreadThree = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadThree setName:@"Thread-3"];
    [ticketsThreadThree start];
}

- (void)run
{
    while (TRUE) 
    {
        // 上锁
        [ticketsCondition lock];
        if(tickets > 0)
        {
            [NSThread sleepForTimeInterval:0.5];
            count = 100 - tickets;
            NSLog(@"当前票数是:%d,售出:%d,线程名:%@",tickets,count,[[NSThread currentThread] name]);
            tickets--;
        }
        else
        {
            break;
        }
        [ticketsCondition unlock];//下锁
        [ticketsCondition signal];
    }
}

- (void)dealloc 
{
    [ticketsThreadone release];
    [ticketsThreadtwo release];
    [ticketsThreadThree release];
    [ticketsCondition release];
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
