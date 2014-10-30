//
//  CalRectangle.m
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import "CalRectangle.h"

@implementation RTRectangle(Math)
- (int) calculateArea
{
    return width_ * height_;
}
- (int) calculatePerimeter
{
    return 2 * (width_ + height_);
}
@end
