//
//  ViewController.m
//  AudioPlay
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize playOrStopButton = playOrStopButton_;
@synthesize recordOrStopButton = recordOrStopButton_;
@synthesize soundURL = soundURL_;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //初始化录音文件的路径
    NSString *tempDir = NSTemporaryDirectory ();
    NSString *soundFilePath = [tempDir stringByAppendingPathComponent: @"sound.caf"];
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    [self setSoundURL:newURL];
    [newURL release];
    
    //建立音频会话
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    audioSession.delegate = self;
    [audioSession setActive: YES error: nil];
    
    //状态变量
    isPlaying_ = NO;
    isRecording_ = NO;
}

//播放声音结束回调
static void simpleSoundFinish()
{
    //弹出提示
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"" 
                          message:@"System Sound Service Play Finish!" 
                          delegate:nil 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:nil, 
                          nil];
    [alert show];
    [alert release];
    
    //震动iPhone
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

//播放声音
- (IBAction)playSimpleSoundBySystemSoundServices:(id)sender
{
    //初始化URL
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"push.wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //创建声音
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);
    
    //增加回调
    AudioServicesAddSystemSoundCompletion(soundID, nil, nil, simpleSoundFinish, nil);
    
    //播放声音
    if (error) 
    {
        //弹出提示
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"" 
                              message:@"加载声音文件错误!" 
                              delegate:nil 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil, 
                              nil];
        [alert show];
        [alert release];
    }
    else
    {
        AudioServicesPlaySystemSound(soundID);
    }
}


//播放或者停止
- (IBAction)playOrStop:(id)sender
{
    //判断是否是正在录音
    if (isRecording_) 
    {
        //停止录音
        [recorder_ stop];
        isRecording_ = NO;
        recorder_ = nil;
        
        //更新按钮
        [recordOrStopButton_ setTitle: @"录制" forState: UIControlStateNormal];
        
        //更新AVAudioSession状态
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
    } 
    
    //判断是否是正在播放
    if (isPlaying_) 
    {
        //停止播放
        [player_ stop];
        isPlaying_ = NO;
        
        //更新按钮
        [playOrStopButton_ setTitle: @"播放" forState: UIControlStateNormal];
    }
    else
    {
        //更新AVAudioSession状态
        NSError * error;
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error: &error];
        [audioSession setActive:YES error: &error];
        
        //创建AVAudioPlayer
        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: soundURL_ error: nil];
        player_ = newPlayer;

        //播放
        [player_ setDelegate: self];
        [player_ prepareToPlay];
        [player_ play];

        isPlaying_ = YES;
        
        //更新按钮
        [playOrStopButton_ setTitle: @"停止" forState: UIControlStateNormal];
    }
}

//录制或者停止
- (IBAction)recordOrStop:(id)sender
{
    //判断是否是正在录音
    if (isRecording_) 
    {
        //停止录音
        [recorder_ stop];
        isRecording_ = NO;
        recorder_ = nil;
        
        //更新按钮
        [recordOrStopButton_ setTitle: @"录制" forState: UIControlStateNormal];
        
        //更新AVAudioSession状态
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
    } 
    else 
    {
        //更新AVAudioSession状态
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error: nil];
        
        //设置属性
        NSDictionary *recordSettings =
        [[NSDictionary alloc] initWithObjectsAndKeys:
         [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
         [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
         [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
         [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
         nil];
        
        //创建AVAudioRecorder
        AVAudioRecorder *newRecorder = [[AVAudioRecorder alloc] initWithURL: soundURL_
                                                                   settings: recordSettings
                                                                      error: nil];
        [recordSettings release];
        recorder_ = newRecorder;
        recorder_.delegate = self;
        [recorder_ prepareToRecord];
        [recorder_ record];
        
        //更新按钮
        [recordOrStopButton_ setTitle: @"停止" forState: UIControlStateNormal];
        isRecording_ = YES;
    }
}



@end
