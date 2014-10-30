//
//  TableShowMasterViewController.h
//  TableShow
//
//  Created by Chendy on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableViewController;

@interface TableShowMasterViewController : UITableViewController

@property (strong, nonatomic) BaseTableViewController *detailViewController;

@end
