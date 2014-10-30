//
//  ShadowView.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize          myShadowOffset = CGSizeMake (-15,  20);// 2 
    float           myColorValues[] = {1.0, 1.0, 1.0, .6};// 3 (White shadow colour) 
    CGColorRef      myColor;// 4 
    CGColorSpaceRef myColorSpace;// 5 
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    float wd = 200;
    float ht = 200;
    CGContextSaveGState(myContext);// 6 
    CGContextSetShadow (myContext, myShadowOffset, 5); // 7 
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1); 
    CGContextFillRect (myContext, CGRectMake (30, 30 , wd/2, ht/2)); 
    myColorSpace = CGColorSpaceCreateDeviceRGB ();// 9 
    myColor = CGColorCreate (myColorSpace, myColorValues);// 10 
    CGContextSetShadowWithColor (myContext, myShadowOffset, 5, myColor);// 11 
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1); 
    CGContextFillRect (myContext, CGRectMake (180,30,wd/2,ht/2)); 
    CGColorRelease (myColor);// 13 
    CGColorSpaceRelease (myColorSpace); // 14 
    CGContextRestoreGState(myContext);// 15 
    
    //文字阴影
    CGContextSaveGState(myContext);
    CGContextSetRGBFillColor (myContext, 0, 0, 0, 1); 
    UIColor* shadowColor = [UIColor whiteColor];
    CGContextSetShadowWithColor(myContext, CGSizeMake(-2, 3), 1, shadowColor.CGColor);
    NSString* shadowStr = @"文字的阴影Shadow!";
    [shadowStr drawInRect:CGRectMake(20, 200, 280, 30) withFont:[UIFont systemFontOfSize:18]];
    CGContextRestoreGState(myContext);
}


@end
