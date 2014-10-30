//
//  PDFView.m
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("Quartz.pdf"), NULL, NULL);
		pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
		CFRelease(pdfURL);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画布翻转
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGPDFPageRef page = CGPDFDocumentGetPage(pdf, 1);
	CGContextSaveGState(context);
	CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
	CGContextConcatCTM(context, pdfTransform);
	CGContextDrawPDFPage(context, page);
	CGContextRestoreGState(context);
}


@end
