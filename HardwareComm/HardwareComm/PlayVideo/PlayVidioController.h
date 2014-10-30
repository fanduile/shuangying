//
//  PlayVidioController.h
//  HardwareComm
//
//  Created by Chendy on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayVidioController : UIViewController
{
    NSURL* videoPath_;
}

@property(nonatomic, retain) NSURL* videoPath;
-(IBAction)playVideoButtonClick:(id)sender;
-(void)movieFinish:(NSNotification*)notification;

@end
