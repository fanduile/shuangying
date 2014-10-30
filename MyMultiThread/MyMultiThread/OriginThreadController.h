//
//  OriginThreadController.h
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pthread.h>
void* threadLoop(void *param);
@interface OriginThreadController : UIViewController
{
    pthread_t threadid_;			//线程ID
	pthread_mutex_t mutext_;		//互斥锁
    bool isRun_;
    UILabel* label_;
    int labelIndex_;
}
@property(nonatomic, assign) bool isRun;
@property(nonatomic, assign) int labelIndex;
@property(nonatomic, retain) IBOutlet UILabel* label;
-(IBAction)threadRun:(id)sender;
@end
