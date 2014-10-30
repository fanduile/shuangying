//
//  GoodsData.h
//  MyMultiThread
//
//  Created by  on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsData : NSObject
{
    NSInteger goodsCount;
}
- (void)produce;
- (void)consume;
@end
