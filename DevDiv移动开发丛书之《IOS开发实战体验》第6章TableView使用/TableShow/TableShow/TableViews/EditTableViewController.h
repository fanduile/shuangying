//
//  EditTableViewController.h
//  RealTool
//
//  Created by Chendy on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* myTableView;
    NSMutableArray* dataSource;
}
@property(nonatomic, retain) IBOutlet UITableView* myTableView;
@property(nonatomic, retain)  NSMutableArray* dataSource;
-(IBAction)refreshData:(id)sender;
@end
