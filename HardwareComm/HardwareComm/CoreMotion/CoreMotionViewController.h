//
//  CoreMotionViewController.h
//  HardwareComm
//
//  Created by Chendy on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreMotion/CMAccelerometer.h>
#import <CoreMotion/CMAccelerometer.h>

@interface CoreMotionViewController : UIViewController
{
    CMMotionManager* motionManager_;
}
@property(nonatomic, retain) CMMotionManager* motionManager;

-(IBAction)getMotion:(id)sender;

@end
