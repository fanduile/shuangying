//
//  CoreMotionViewController.m
//  HardwareComm
//
//  Created by Chendy on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CoreMotionViewController.h"

@implementation CoreMotionViewController
@synthesize motionManager = motionManager_;

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
    motionManager_ = [[CMMotionManager alloc] init];
    if (!motionManager_.accelerometerAvailable) 
    {
        // 失败处理代码 // 检查传感器到底在设备上是否可用
    }
    //主动获得
    motionManager_.accelerometerUpdateInterval = 0.01; // 告诉manager，更新频率是100Hz
    [motionManager_ startAccelerometerUpdates]; // 开始更新，后台线程开始运行。这是pull方式。
    

    //被动获得
    motionManager_.accelerometerUpdateInterval = 0.5;
    [motionManager_ startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]  
                                       withHandler:^(CMAccelerometerData*accelerometerData,NSError*error)  
    {  
        CMAcceleration accleleration=accelerometerData.acceleration;  
        
        NSString*string=[NSString stringWithFormat:@"accleleration[%.2f, %.2f, %.2f]", accleleration.x, accleleration.y, accleleration.z];  
        NSLog(@"%@",string);  
        
    }]; 

}
-(IBAction)getMotion:(id)sender
{
    CMAcceleration accleleration = motionManager_.accelerometerData.acceleration;  
    NSString*string=[NSString stringWithFormat:@"accleleration[%.2f, %.2f, %.2f]", accleleration.x, accleleration.y, accleleration.z];  
    NSLog(@"%@",string); 
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
