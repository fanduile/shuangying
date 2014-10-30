//
//  CanvasView.m
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView
@synthesize type = type_;
@synthesize phase = phase_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        type_ = -1;
        phase_ = -5;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    switch (type_) 
    {
        case 0://画线
        {
            //[self drawSingleLineInContext:UIGraphicsGetCurrentContext()];
            [self drawLineInContext:UIGraphicsGetCurrentContext()];
            break;
        }
        case 1://画矩形
        {
            [self drawRectInContext:UIGraphicsGetCurrentContext()];
            break;
        }
        case 2://画椭圆
        {
            [self drawElipseInContext:UIGraphicsGetCurrentContext()];
            break;
        }
        case 3://画贝塞尔曲线
        {
            [self drawBezieInContext:UIGraphicsGetCurrentContext()];
            break;
        }
        case 4:
        {
            [self drawDashLineInContext:UIGraphicsGetCurrentContext()];
            break;
        }
        default:
            break;
    }
}

-(void)drawSingleLineInContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, 10.0, 30.0);
	CGContextAddLineToPoint(context, 310.0, 30.0);
	CGContextStrokePath(context);
}

-(void)drawLineInContext:(CGContextRef)context
{
	// 设置线条颜色为白色
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	//设置线条宽度为8
	CGContextSetLineWidth(context, 8.0);
	// 从左到右画一条直线
	CGContextMoveToPoint(context, 10.0, 30.0);
	CGContextAddLineToPoint(context, 310.0, 30.0);
	CGContextStrokePath(context);
	// 画线条序列，并且首尾连接
	CGPoint addLines[] =
	{
		CGPointMake(10.0, 90.0),
		CGPointMake(70.0, 60.0),
		CGPointMake(130.0, 90.0),
		CGPointMake(190.0, 60.0),
		CGPointMake(250.0, 90.0),
		CGPointMake(310.0, 60.0),
	};
	CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
	CGContextStrokePath(context);
	// 画线条序列，不连接
	CGPoint strokeSegments[] =
	{
		CGPointMake(10.0, 150.0),
		CGPointMake(70.0, 120.0),
		CGPointMake(130.0, 150.0),
		CGPointMake(190.0, 120.0),
		CGPointMake(250.0, 150.0),
		CGPointMake(310.0, 120.0),
	};
	CGContextStrokeLineSegments(context, strokeSegments, sizeof(strokeSegments)/sizeof(strokeSegments[0]));
}

-(void)drawRectInContext:(CGContextRef)context
{
	//设置线条颜色
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	//设置填充颜色
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	//设置线条宽度
	CGContextSetLineWidth(context, 2.0);
	
	//添加一个矩形区域到当前路径并一次性绘制
	CGContextAddRect(context, CGRectMake(30.0, 30.0, 60.0, 60.0));
	CGContextStrokePath(context);
	
	//直接在指定矩形区域一次性绘制
	CGContextStrokeRect(context, CGRectMake(30.0, 120.0, 60.0, 60.0));
	
	//直接在指定矩形区域一次性绘制，并指定宽度
	CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 10.0);
	// Demonstate the stroke is on both sides of the path.
    
    //临时改变绘图状态
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 2.0);
	CGContextRestoreGState(context);
	
	CGRect rects[] = 
	{
		CGRectMake(120.0, 30.0, 60.0, 60.0),
		CGRectMake(120.0, 120.0, 60.0, 60.0),
		CGRectMake(120.0, 210.0, 60.0, 60.0),
	};
    
	// Bulk call to add rects to the current path.
	CGContextAddRects(context, rects, sizeof(rects)/sizeof(rects[0]));
	CGContextStrokePath(context);
//	
	//通过两种方式创建填充矩形
	// 添加/填充 路径
	
    //临时改变绘图状态
	CGContextSaveGState(context);
    //设置填充颜色
	CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 2.0);
    CGContextAddRect(context, CGRectMake(210.0, 30.0, 60.0, 60.0));
	CGContextFillPath(context);
    CGContextRestoreGState(context);
	//直接调用方法填充矩形.
	CGContextFillRect(context, CGRectMake(210.0, 120.0, 60.0, 60.0));
    
}

-(void)drawElipseInContext:(CGContextRef)context
{
    //设置线条颜色
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	//设置填充颜色
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	//设置线条宽度
	CGContextSetLineWidth(context, 2.0);
	
	// 增加一个正圆椭圆到当前路径，并绘画
	CGContextAddEllipseInRect(context, CGRectMake(10.0, 30.0, 60.0, 60.0));
	CGContextStrokePath(context);
	
	//简易画法
	CGContextStrokeEllipseInRect(context, CGRectMake(10.0, 120.0, 100.0, 60.0));
	
	//简易填充椭圆
	CGContextFillEllipseInRect(context, CGRectMake(10.0, 210.0, 100.0, 60.0));
	
	//绘画两个分离的弧形
	CGContextAddArc(context, 150.0, 60.0, 30.0, 0.0, M_PI/2.0, false);
	CGContextStrokePath(context);
	CGContextAddArc(context, 150.0, 60.0, 30.0, 3.0*M_PI/2.0, M_PI, true);
	CGContextStrokePath(context);
    
	//绘画两个连接起来的弧形，并且方向相反
	CGContextAddArc(context, 150.0, 150.0, 30.0, 0.0, M_PI/2.0, false);
	CGContextAddArc(context, 150.0, 150.0, 30.0, 3.0*M_PI/2.0, M_PI, true);
	CGContextStrokePath(context);
    
	// 绘画两个连接起来的弧形，并且方向相同
	CGContextAddArc(context, 150.0, 240.0, 30.0, 0.0, M_PI/2.0, false);
	CGContextAddArc(context, 150.0, 240.0, 30.0, M_PI, 3.0*M_PI/2.0, false);
	CGContextStrokePath(context);
    
    
	
//	// Stroke an arc using AddArcToPoint
//	CGPoint p[3] =
//	{
//		CGPointMake(210.0, 30.0),
//		CGPointMake(210.0, 60.0),
//		CGPointMake(240.0, 60.0),
//	};
//	CGContextMoveToPoint(context, p[0].x, p[0].y);
//	CGContextAddArcToPoint(context, p[1].x, p[1].y, p[2].x, p[2].y, 30.0);
//	CGContextStrokePath(context);
//	
//	// Show the two segments that are used to determine the tangent lines to draw the arc.
//	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//	CGContextAddLines(context, p, sizeof(p)/sizeof(p[0]));
//	CGContextStrokePath(context);
//	
//	// As a bonus, we'll combine arcs to create a round rectangle!
//	
//	// Drawing with a white stroke color
//	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//    
//	// If you were making this as a routine, you would probably accept a rectangle
//	// that defines its bounds, and a radius reflecting the "rounded-ness" of the rectangle.
//	CGRect rrect = CGRectMake(210.0, 90.0, 60.0, 60.0);
//	CGFloat radius = 10.0;
//	// NOTE: At this point you may want to verify that your radius is no more than half
//	// the width and height of your rectangle, as this technique degenerates for those cases.
//	
//	// In order to draw a rounded rectangle, we will take advantage of the fact that
//	// CGContextAddArcToPoint will draw straight lines past the start and end of the arc
//	// in order to create the path from the current position and the destination position.
//	
//	// In order to create the 4 arcs correctly, we need to know the min, mid and max positions
//	// on the x and y lengths of the given rectangle.
//	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
//	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
//	
//	// Next, we will go around the rectangle in the order given by the figure below.
//	//       minx    midx    maxx
//	// miny    2       3       4
//	// midy   1 9              5
//	// maxy    8       7       6
//	// Which gives us a coincident start and end point, which is incidental to this technique, but still doesn't
//	// form a closed path, so we still need to close the path to connect the ends correctly.
//	// Thus we start by moving to point 1, then adding arcs through each pair of points that follows.
//	// You could use a similar tecgnique to create any shape with rounded corners.
//	
//	// Start at 1
//	CGContextMoveToPoint(context, minx, midy);
//	// Add an arc through 2 to 3
//	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
//	// Add an arc through 4 to 5
//	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
//	// Add an arc through 6 to 7
//	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//	// Add an arc through 8 to 9
//	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
//	// Close the path
//	CGContextClosePath(context);
//	// Fill & stroke the path
//	CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)drawBezieInContext:(CGContextRef)context
{
	// Drawing with a white stroke color
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, 2.0);
	
	// Draw a bezier curve with end points s,e and control points cp1,cp2
	CGPoint s = CGPointMake(30.0, 120.0);
	CGPoint e = CGPointMake(300.0, 120.0);
	CGPoint cp1 = CGPointMake(120.0, 30.0);
	CGPoint cp2 = CGPointMake(210.0, 210.0);
	CGContextMoveToPoint(context, s.x, s.y);
	CGContextAddCurveToPoint(context, cp1.x, cp1.y, cp2.x, cp2.y, e.x, e.y);
	CGContextStrokePath(context);
	
	// Show the control points.
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextMoveToPoint(context, s.x, s.y);
	CGContextAddLineToPoint(context, cp1.x, cp1.y);
	CGContextMoveToPoint(context, e.x, e.y);
	CGContextAddLineToPoint(context, cp2.x, cp2.y);
	CGContextStrokePath(context);
	
	// Draw a quad curve with end points s,e and control point cp1
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	s = CGPointMake(30.0, 300.0);
	e = CGPointMake(270.0, 300.0);
	cp1 = CGPointMake(150.0, 180.0);
	CGContextMoveToPoint(context, s.x, s.y);
	CGContextAddQuadCurveToPoint(context, cp1.x, cp1.y, e.x, e.y);
	CGContextStrokePath(context);
    
	// Show the control point.
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextMoveToPoint(context, s.x, s.y);
	CGContextAddLineToPoint(context, cp1.x, cp1.y);
	CGContextStrokePath(context);
}

-(void)drawDashLineInContext:(CGContextRef)context
{
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    //CGFloat pattern[3] = {10.0, 10.0, 10.0};
	CGFloat pattern[3] = {10.0, 10.0, 30.0};
	CGContextSetLineDash(context,phase_, pattern, 3);
	
	CGContextMoveToPoint(context, 10.0, 20.0);
	CGContextAddLineToPoint(context, 310.0, 20.0);
	CGContextMoveToPoint(context, 160.0, 30.0);
	CGContextAddLineToPoint(context, 160.0, 130.0);
	CGContextAddRect(context, CGRectMake(10.0, 30.0, 100.0, 100.0));
	CGContextAddEllipseInRect(context, CGRectMake(210.0, 30.0, 100.0, 100.0));
	// And width 2.0 so they are a bit more visible
	CGContextSetLineWidth(context, 4.0);
	CGContextStrokePath(context);
}


@end
