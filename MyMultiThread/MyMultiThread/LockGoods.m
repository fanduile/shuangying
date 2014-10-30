//
//  LockGoods.m
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LockGoods.h"

@implementation LockGoods
-(id)init
{
    if (self = [super init]) 
    {
        //在仅使用 lock和unlock时 下面的几个类是一样的
        lockObj = [[NSLock alloc] init];
        //lockObj = [[NSCondition alloc] init];
    }
    return  self;
}
- (void)dealloc
{
    [lockObj release];
    [super dealloc];
}
- (void)produce
{
    for (;![[NSThread currentThread] isCancelled] ; ) 
    {
        [lockObj lock];
        if (goodsCount > 0) 
        {
            continue;
        }
        ++goodsCount;
        NSLog(@"produce one goods,  goods count is %d." , goodsCount);
        [lockObj unlock];
    }
}
- (void)consume
{
    for (;![[NSThread currentThread] isCancelled]; ) 
    {
        [lockObj lock];
        if (goodsCount <= 0) 
        {
            return;
        }
        --goodsCount;
        NSLog(@"consume one goods,  goods count is %d." , goodsCount);
        [lockObj unlock];
    }
}
@end


