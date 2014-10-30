//
//  QuartzPDFController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFView;
@interface QuartzPDFController : UIViewController
{
    PDFView* pdfView_;
}

@property(nonatomic, retain) PDFView* pdfView;

@end
