//
//  NSOperationController.h
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSOperationController : UIViewController
{
    
}

-(IBAction)clickThread:(id)sender;
-(IBAction)clickPriority:(id)sender;
-(IBAction)clickDependClick:(id)sender;
-(IBAction)produceConsumeClick:(id)sender;
-(IBAction)produceConsumeLock:(id)sender;
-(IBAction)produceConsumeCondition:(id)sender;
@end
