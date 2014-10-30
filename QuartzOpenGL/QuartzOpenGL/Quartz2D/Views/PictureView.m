//
//  PictureView.m
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PictureView.h"
#import "AFUIImageReflection.h"
@implementation PictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"realtool.png" ofType:nil];
		UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
        //img = [img addImageReflection:0.3];
		image = CGImageRetain(img.CGImage);
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect imageRect;
    
    imageRect.origin = CGPointMake(50.0,10.0);
	imageRect.size = CGSizeMake(200, 200);
    
    CGRect clipRect = CGRectMake(90, 90, 100, 100);
    CGContextClipToRect(context, clipRect);
    
//	imageRect.origin = CGPointMake(50.0,30.0);
//	imageRect.size = CGSizeMake(160, 160* 1.3);
//    
//    CGRect clipRect = CGRectMake(90, 90, 100, 100);
//    CGContextClipToRect(context, clipRect);
    
    //翻转画布
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);  //画布的高度
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, imageRect, image);
    CGContextRestoreGState(context);
}

-(void)dealloc
{
    CGImageRelease(image);
    [super dealloc];
}


@end
