//
//  MultiThreadMasterViewController.h
//  MyMultiThread
//
//  Created by  on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiThreadDetailViewController;

@interface MultiThreadMasterViewController : UITableViewController

@property (strong, nonatomic) MultiThreadDetailViewController *detailViewController;

@end
