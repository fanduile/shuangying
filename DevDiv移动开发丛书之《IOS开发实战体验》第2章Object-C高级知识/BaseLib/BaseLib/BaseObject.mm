//
//  BaseObject.m
//  BaseLib
//
//  Created by Chendy on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseObject.h"
#import "BaseMath.h"

@implementation BaseObject
-(int)add:(int)a with:(int)b
{
    BaseMath math;
    return math.add(a,b);
}
-(int)sub:(int)a with:(int)b
{
    BaseMath math;
    return math.sub(a, b);
}

- (void)dealloc
{
    NSLog(@"ObjC Eng");
    [super dealloc];
}
@end
