//
//  CommViewController.h
//  HardwareComm
//
//  Created by Chendy on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface CommViewController : UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

- (IBAction)makeCall:(NSString *)phoneNumber;
- (IBAction)sendSMS;
- (IBAction)sendSMSInApp;

+ (void) sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body;
-(IBAction)sendMail:(id)sender;
-(IBAction)sendMailInApp:(id)sender;


@end
