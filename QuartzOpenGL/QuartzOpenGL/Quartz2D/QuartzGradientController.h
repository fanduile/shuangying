//
//  QuartzGradientController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GradientView;
@interface QuartzGradientController : UIViewController
{
    GradientView* gradientView_;
}

@property(nonatomic, retain) GradientView* gradientView;

-(IBAction)segmentChange:(id)sender;

@end
