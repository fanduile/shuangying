//
//  GradientView.m
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
@synthesize type = type_;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        type_ = 0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clip = CGRectInset(CGContextGetClipBoundingBox(context), 20.0, 20.0);
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
        29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
        0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
    };
    CGContextSaveGState(context);
    CGPoint start = CGPointMake(10, 10);
    CGPoint end = CGPointMake(300, 300);
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
   if(type_ == 0)
   {
       CGContextClipToRect(context, clip);
       CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
       
   }
    else if(type_ == 1)
    {
        CGPoint startPt = CGPointMake(155, 155);
        CGPoint endPt = startPt;
        CGFloat startRadius = 70;
        CGFloat endRadius = 145;
        CGContextDrawRadialGradient(context, gradient, startPt, startRadius, endPt, endRadius, kCGGradientDrawsBeforeStartLocation);
    }
    CGContextRestoreGState(context);
}


@end
