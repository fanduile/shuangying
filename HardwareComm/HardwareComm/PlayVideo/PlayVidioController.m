//
//  PlayVidioController.m
//  HardwareComm
//
//  Created by Chendy on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayVidioController.h"

@implementation PlayVidioController
@synthesize videoPath = videoPath_;

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
    [self playVideoButtonClick:nil];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)playVideoButtonClick:(id)sender
{
    if(videoPath_ == nil)
    {
        return;
    }
    MPMoviePlayerController *movieController = [[MPMoviePlayerController alloc] initWithContentURL:videoPath_]; //设置要播放的视频的位置
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:movieController]; //设置视频播放结束后的回调处理
    [[self view] addSubview:[movieController view]];
    float halfHeight = [[self view] bounds].size.height / 2.0;
    float width = [[self view] bounds].size.width;
    [[movieController view] setFrame:CGRectMake(0, 0, width, halfHeight)];
    [movieController play]; //播放视频
    
}

-(void)movieFinish:(NSNotification*)notification
{
    MPMoviePlayerController *movieController = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:movieController];
    [movieController release]; //释放资源
    movieController = nil;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [videoPath_ release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
