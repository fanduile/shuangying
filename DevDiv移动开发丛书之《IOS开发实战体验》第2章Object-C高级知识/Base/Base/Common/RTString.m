//
//  RTString.m
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import "RTString.h"

@implementation NSString(RTString)

-(void)alert
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                    message:self
                                                   delegate:nil
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void)makeCall
{
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self]];
    NSLog(@"make call, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL];   
}

-(void)sendSMS
{
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self]];
    NSLog(@"send sms, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL]; 
}

-(void)sendEmail
{
    NSURL *emailURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self]];
    NSLog(@"send sms, URL=%@", emailURL);
    [[UIApplication sharedApplication] openURL:emailURL];   
}
@end
