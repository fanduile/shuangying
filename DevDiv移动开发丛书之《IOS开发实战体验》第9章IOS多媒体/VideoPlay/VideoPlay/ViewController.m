//
//  ViewController.m
//  VideoPlay
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize movieNameLabel = movieNameLabel_;
@synthesize moviePic = moviePic_;
@synthesize theURL = theURL_;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //加载信息
    [[self moviePic] setImage:[UIImage imageNamed:@"cat.png"]];
    
    //加载文件名称
    [[self movieNameLabel] setText:@"Cat"];
    
    //加载视频URL
    [self setTheURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"catmov" ofType:@"mov"]]];
}

//播放视频回调
-(void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    
    // Release the movie instance created in playMovieAtURL:
    [theMovie release];
}

//播放视频
- (IBAction)playVideo:(id)sender
{
    MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL: theURL_];
    
    theMovie.scalingMode = MPMovieScalingModeAspectFill;
    //theMovie.movieControlMode = MPMovieControlModeHidden;
    
    // Register for the playback finished notification.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:theMovie];
        
    // Movie playback is asynchronous, so this method returns immediately.
    [theMovie play];
}


@end
