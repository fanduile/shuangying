//
//  GoodsData.m
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodsData.h"

@implementation GoodsData
- (void)produce
{
    for (;![[NSThread currentThread] isCancelled] ; ) 
    {
        @synchronized(self)
        {
            if (goodsCount > 0) 
            {
                continue;
            }
            ++goodsCount;
            NSLog(@"produce one goods,  goods count is %d." , goodsCount);
        }
    }
}

- (void)consume
{
    for (;![[NSThread currentThread] isCancelled]; ) 
    {
        @synchronized(self)
        {
            if (goodsCount <= 0) 
            {
                return;
            }
            --goodsCount;
            NSLog(@"consume one goods,  goods count is %d." , goodsCount);
        }
    }
}
@end
