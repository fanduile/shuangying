//
//  ViewController.h
//  AudioPlay
//
//  Created by Kevin Zhao on 12-1-31.
//  Copyright (c) 2012年 FH. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioSessionDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    //声音ID
    SystemSoundID soundID;
    
    //是否正在播放
    BOOL isPlaying_;
    
    //是否正在录制
    BOOL isRecording_;
    
    //播放或者停止按钮
    UIButton *playOrStopButton_;
    
    //录制或者停止按钮
    UIButton *recordOrStopButton_;
    
    //录制的音频文件的路径
    NSURL *soundURL_;
    
    //音频录制对象
    AVAudioRecorder *recorder_;
    
    //音频播放对象
    AVAudioPlayer *player_;
}

@property(nonatomic, retain)IBOutlet UIButton *playOrStopButton;
@property(nonatomic, retain)IBOutlet UIButton *recordOrStopButton;
@property(nonatomic, retain)NSURL *soundURL;

//播放声音
- (IBAction)playSimpleSoundBySystemSoundServices:(id)sender;


//播放或者停止
- (IBAction)playOrStop:(id)sender;

//录制或者停止
- (IBAction)recordOrStop:(id)sender;


@end
