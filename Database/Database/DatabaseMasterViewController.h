//
//  DatabaseMasterViewController.h
//  Database
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatabaseDetailViewController;

@interface DatabaseMasterViewController : UITableViewController

@property (strong, nonatomic) DatabaseDetailViewController *detailViewController;

@end
