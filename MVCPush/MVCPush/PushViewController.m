//
//  PushViewController.m
//  MVCPush
//
//  Created by Chendy on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PushViewController.h"
#import "SSLHelper.h"
#import "RemoteNotification.h"
#include <openssl/evp.h>

@implementation PushViewController

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
    self.title = @"Push演示";
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)doPush:(id)sender
{
    
    const char     *deviceTokenHex = NULL;
    deviceTokenHex = "31a21c2e 4c88110d 4296dbc9 fe220874 f59ff456 9485b0dd ab9804f1 938c6fed";
    Payload *payload = (Payload*)malloc(sizeof(Payload));
    init_payload(payload);
    
    // This is the message the user gets once the Notification arrives
    payload->message = "Mobile Device Message!";
    
    // This is the red numbered badge that appears over the Icon
    payload->badgeNumber = 1;
    
    // This is the Caption of the Action key on the Dialog that appears
    payload->actionKeyCaption = "Caption of the second Button";
    
    // These are two dictionary key-value pairs with user-content
    payload->dictKey[0] = "Key1";
    payload->dictValue[0] = "Value1";
    
    payload->dictKey[1] = "Key2";
    payload->dictValue[1] = "Value2";
    
    /* Send the payload to the phone */
    printf("Sending APN to Device with UDID: %s\n", deviceTokenHex);
    send_remote_notification(deviceTokenHex, payload);
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
