//
//  ImageView.m
//  UIImageDemo
//
//  Created by Kevin Zhao on 11-12-27.
//  Copyright (c) 2011年 FH. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //加载UIImage
    UIImage *image = [UIImage imageNamed:@"test.png"];
    
    //绘制
    [image drawInRect:rect blendMode:kCGBlendModeDifference alpha:1.0];
}


@end
