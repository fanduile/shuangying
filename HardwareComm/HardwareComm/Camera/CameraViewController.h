//
//  CameraViewController.h
//  HardwareComm
//
//  Created by Chendy on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImageView* imageView_;
    UIView* cameraBgView_;
    UIButton* playVideoButton_;
    NSURL* filePath_;
}

@property(nonatomic, retain) IBOutlet UIImageView* imageView;
@property(nonatomic, retain) IBOutlet UIView* cameraBgView;
@property(nonatomic, retain) IBOutlet UIButton* playVideoButton;
@property(nonatomic, retain) NSURL* filePath;

-(IBAction)takePicktureButtonClick:(id)sender;
-(IBAction)takeVideoButtonClick:(id)sender;
-(IBAction)cancelCemera:(id)sender;
-(IBAction)playVideoBtnClick:(id)sender;

@end
