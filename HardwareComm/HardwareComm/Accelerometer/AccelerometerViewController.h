//
//  AccelerometerViewController.h
//  HardwareComm
//
//  Created by Chendy on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccelerometerViewController : UIViewController<UIAccelerometerDelegate>
{
    UILabel* xLabel_;
    UILabel* yLabel_;
    UILabel* zLabel_;
}

@property(nonatomic, retain) IBOutlet UILabel* xLabel;
@property(nonatomic, retain) IBOutlet UILabel* yLabel;
@property(nonatomic, retain) IBOutlet UILabel* zLabel;
@end
