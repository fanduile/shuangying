//
//  NotificationViewController.h
//  MVCPush
//
//  Created by Chendy on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const BNRColorChangedNotification;
@interface NotificationViewController : UIViewController
{
    
}

-(IBAction)sendNotification:(id)sender;

-(void)notiChangeBackgroundColor:(NSNotification*)notify;

@end
