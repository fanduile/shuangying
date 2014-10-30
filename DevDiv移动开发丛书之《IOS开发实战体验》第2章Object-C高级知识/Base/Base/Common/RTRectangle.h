//
//  RTRectangle.h
//  Base
//
//  Created by Chendy on 11-12-6.
//  Copyright (c) 2011年 睿拓(RealTool)工作室(realtool@163.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTRectangle : NSObject
{
    double width_;
    double height_;
}

@property(nonatomic, assign) double width;
@property(nonatomic, assign) double height;

@end
