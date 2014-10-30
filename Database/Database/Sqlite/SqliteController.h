//
//  SqliteController.h
//  Database
//
//  Created by  on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SqliteController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    sqlite3* database;
    UITableView* table_;
    NSMutableArray* dataSource_;
}

@property(nonatomic, retain) IBOutlet UITableView* table;
@property(nonatomic, retain) NSMutableArray* dataSource;


- (void)initDB;
-(void)openSQLiteDB;
- (void)getUserInfo;
-(void)deleteUser;

-(IBAction)addRealTool:(id)sender;
-(IBAction)addStudio:(id)sender;
-(IBAction)deleteSQLiteExe:(id)sender;


-(IBAction)searchTable:(id)sender;
@end
