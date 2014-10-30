//
//  QuartzOpenGLMasterViewController.h
//  QuartzOpenGL
//
//  Created by  on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuartzOpenGLDetailViewController;

@interface QuartzOpenGLMasterViewController : UITableViewController
{
    NSMutableArray* dataSource_;
    
}

@property (retain, nonatomic) QuartzOpenGLDetailViewController *detailViewController;
@property(nonatomic, retain) NSMutableArray* dataSource;

@end
