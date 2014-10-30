//
//  NSOperationController.m
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSOperationController.h"
#import "MyOperation.h"
#import "GoodsData.h"
#import "LockGoods.h"
#import "ConditionGoods.h"
@implementation NSOperationController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)clickThread:(id)sender
{
    MyOperation * myobject = [[MyOperation alloc] init];
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];[queue setMaxConcurrentOperationCount:1];
    NSOperation* task1 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 1 is run!"] autorelease];
    [queue addOperation:task1];
    NSOperation* task2 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 2 is run!"] autorelease];
    [queue addOperation:task2];
    NSOperation* task3 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 3 is run!"] autorelease];
    [queue addOperation:task3];
    [queue waitUntilAllOperationsAreFinished];//等待。
    NSLog(@"all task has finished!");
}

-(IBAction)clickPriority:(id)sender
{
    MyOperation * myobject = [[MyOperation alloc] init];
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:3];
    NSOperation* task1 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 1 is run!"] autorelease];
    [task1 setQueuePriority:4];
    [queue addOperation:task1];
    NSOperation* task2 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 2 is run!"] autorelease];
    [task2 setQueuePriority:3];
    [queue addOperation:task2];
    NSOperation* task3 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 3 is run!"] autorelease];
    [task3 setQueuePriority:3];
    [queue addOperation:task3];
    NSOperation* task4 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 4 is run!"] autorelease];
    [task4 setQueuePriority:4];
    [queue addOperation:task4];
    [queue waitUntilAllOperationsAreFinished];//等待。
    NSLog(@"all task has finished!");
}
-(IBAction)clickDependClick:(id)sender
{
    MyOperation * myobject = [[MyOperation alloc] init];
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:3];
    NSOperation* task1 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 1 is run!"] autorelease];
    NSOperation* task2 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 2 is run!"] autorelease];
    NSOperation* task3 = [[[NSInvocationOperation alloc] initWithTarget: myobject selector:@selector(threadMain:) object:@"task 3 is run!"] autorelease];
    
    [task1 addDependency:task2];
    [task1 addDependency:task3];
    
    [queue addOperation:task1];
    [queue addOperation:task2];
    [queue addOperation:task3];
}


-(IBAction)produceConsumeClick:(id)sender
{
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];
    GoodsData* synData = [[[GoodsData alloc] init] autorelease];
    NSOperation* produce = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(produce) object:nil] autorelease];//创建生产者线程操作
    NSOperation* consume = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(consume) object:nil] autorelease];//创建消费者线程操作
    [queue addOperation:produce];
    [queue addOperation:consume];
}

-(IBAction)produceConsumeLock:(id)sender
{
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];
    LockGoods* synData = [[[LockGoods alloc] init] autorelease];
    NSOperation* produce = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(produce) object:nil] autorelease];//创建生产者线程操作
    NSOperation* consume = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(consume) object:nil] autorelease];//创建消费者线程操作
    [queue addOperation:produce];
    [queue addOperation:consume];
}

-(IBAction)produceConsumeCondition:(id)sender
{
    NSOperationQueue * queue=[[NSOperationQueue alloc] init];
    ConditionGoods* synData = [[[ConditionGoods alloc] init] autorelease];
    NSOperation* produce = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(produce) object:nil] autorelease];//创建生产者线程操作
    NSOperation* consume = [[[NSInvocationOperation alloc] initWithTarget:synData selector:@selector(consume) object:nil] autorelease];//创建消费者线程操作
    [queue addOperation:produce];
    [queue addOperation:consume];
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
