//
//  MVCMasterViewController.h
//  MVCPush
//
//  Created by Chendy on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVCViewController;

@interface MVCMasterViewController : UITableViewController

@property (strong, nonatomic) MVCViewController *detailViewController;

@end
