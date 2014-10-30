//
//  MyOperation.m
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyOperation.h"
@implementation MyOperation
-(void)main
{ 
    NSLog(@"task is runing!"); 
}

- (void)threadMain:(id)argv
{
    NSLog(@"%@" , argv);
}
@end
