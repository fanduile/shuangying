//
//  CommViewController.m
//  HardwareComm
//
//  Created by Chendy on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommViewController.h"

@implementation CommViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)makeCall:(NSString *)phoneNumber
{    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];
    NSLog(@"make call, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL];    
}

- (IBAction)sendSMS
{
    NSString* numberAfterClear = @"186-0123-0123";
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", numberAfterClear]];
    
    NSLog(@"send sms, URL=%@", phoneNumberURL);
    
    [[UIApplication sharedApplication] openURL:phoneNumberURL]; 
}

- (IBAction)sendSMSInApp 
{
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	NSLog(@"can send SMS [%d]", canSendSMS);	
	if (canSendSMS) 
    {
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = self;
		picker.navigationBar.tintColor = [UIColor blackColor];
		picker.body = @"send SMS in App";
		picker.recipients = [NSArray arrayWithObject:@"186-0123-0123"];
		[self presentModalViewController:picker animated:YES];
		[picker release];		
	}	
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result 
{
	switch (result) {
		case MessageComposeResultCancelled:
            NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			NSLog(@"Result: Sent");
			break;
		case MessageComposeResultFailed:
			NSLog(@"Result: Failed");
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];	
}

-(IBAction)sendMail:(id)sender
{
    [CommViewController sendEmail:@"realtool@163.com" cc: @"realtool@163.com" subject:@"test email" body:@"test email body"];
}
+(void) sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body
{
    NSString* str = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                     to, cc, subject, body];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(IBAction)sendMailInApp:(id)sender
{
    MFMailComposeViewController* pc = [[MFMailComposeViewController alloc] init];
    pc.mailComposeDelegate = self;
    UIImage* image = [UIImage imageNamed:@"button_gray.png"];
    [pc addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"mail"];
    [self presentModalViewController:pc animated:YES];
    [pc release];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error 
{
    NSString *msg;
    switch (result) 
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            break;
        default:
            break;
    }
    NSLog(@"发送结果：%@", msg);
    [controller dismissModalViewControllerAnimated:YES];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
