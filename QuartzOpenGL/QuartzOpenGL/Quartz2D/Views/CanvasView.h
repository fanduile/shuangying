//
//  CanvasView.h
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView
{
    int type_;
    float phase_;
}
@property(nonatomic, assign) int type;
@property(nonatomic, assign) float phase;

//画一条直线
-(void)drawSingleLineInContext:(CGContextRef)context;
//画多线直线
-(void)drawLineInContext:(CGContextRef)context;
//画矩形
-(void)drawRectInContext:(CGContextRef)context;
//画椭圆
-(void)drawElipseInContext:(CGContextRef)context;
//贝塞尔曲线
-(void)drawBezieInContext:(CGContextRef)context;
//画虚线
-(void)drawDashLineInContext:(CGContextRef)context;
@end
