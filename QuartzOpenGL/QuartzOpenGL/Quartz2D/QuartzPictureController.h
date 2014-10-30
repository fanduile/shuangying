//
//  QuartzPictureController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PictureView;
@interface QuartzPictureController : UIViewController
{
    PictureView* pictureView_;
}

@property(nonatomic, retain) PictureView* pictureView;

@end
