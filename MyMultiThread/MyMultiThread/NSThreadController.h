//
//  NSThreadController.h
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSThreadController : UIViewController
{
    int tickets;
    int count;
    NSThread* ticketsThreadone;
    NSThread* ticketsThreadtwo;
    NSThread* ticketsThreadThree;
    NSCondition* ticketsCondition;
}



@end
