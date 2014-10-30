//
//  BaseTableViewController.h
//  TableShow
//
//  Created by Chendy on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* table_;
}
@property(nonatomic, retain) IBOutlet UITableView* table;

@end
