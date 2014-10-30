//
//  ConditionGoods.m
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConditionGoods.h"

@implementation ConditionGoods
-(id)init
{
    if (self = [super init]) 
    {
        condition = [[NSCondition alloc] init];
    }
    return  self;
}
- (void)dealloc
{
    [condition release];
    [super dealloc];
}
- (void)produce
{
    for (;![[NSThread currentThread] isCancelled] ; ) 
    {
        
        [condition lock];
        ++goodsCount;
        NSLog(@"produce one goods,  goods count is %d." , goodsCount);
        [condition signal];//唤醒一个因condition而等待得线程
        //[condition broadcast];//唤醒所有因condition而等待得线程
        [condition unlock];
    }
}
- (void)consume
{
    for (;![[NSThread currentThread] isCancelled]; ) 
    {
        [condition lock];
        if(goodsCount <= 0) 
        {
            [condition wait];//释放锁 同时线程进入等待状态。
        }
        --goodsCount;
        NSLog(@"consume one goods,  goods count is %d." , goodsCount);
        [condition unlock];
    }
}

@end
