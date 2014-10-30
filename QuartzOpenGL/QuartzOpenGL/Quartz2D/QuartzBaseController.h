//
//  QuartzBaseController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CanvasView;
@interface QuartzBaseController : UIViewController
{
    UISegmentedControl* segment_;
    UISlider* slider_;
    CanvasView* canvasView_;
}

@property(nonatomic, retain) IBOutlet UISegmentedControl* segment;
@property(nonatomic, retain) IBOutlet UISlider* slider;
@property(nonatomic, retain) CanvasView* canvasView;
-(IBAction)selectButton:(int)sender;
-(IBAction)drawDashLine:(id)sender;
-(IBAction)slideChange:(id)sender;
@end
