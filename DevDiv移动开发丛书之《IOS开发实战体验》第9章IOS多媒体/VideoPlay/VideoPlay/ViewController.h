//
//  ViewController.h
//  VideoPlay
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController
{

    //用于显示视频名称
    UILabel *movieNameLabel_;
    
    //用于显示视频截图
    UIImageView *moviePic_;
    
    //用于播放视频的URL
    NSURL *theURL_;
}

@property(nonatomic, retain)IBOutlet UILabel *movieNameLabel;
@property(nonatomic, retain)IBOutlet UIImageView *moviePic;
@property(nonatomic, retain)NSURL *theURL;

//播放视频
- (IBAction)playVideo:(id)sender;

//播放视频回调
-(void)myMovieFinishedCallback:(NSNotification*)aNotification;

@end
